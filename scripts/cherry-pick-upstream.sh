#!/bin/bash
# Cherry-pick a commit from upstream and log it
# Usage: ./scripts/cherry-pick-upstream.sh <commit-hash>

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <commit-hash>"
    echo "Example: $0 abc1234"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
COMMIT="$1"

cd "$REPO_DIR"

# Get commit info
COMMIT_MSG=$(git log --format="%s" -1 "$COMMIT" 2>/dev/null)
if [ -z "$COMMIT_MSG" ]; then
    echo "Error: Commit $COMMIT not found. Did you run 'git fetch upstream'?"
    exit 1
fi

SHORT_HASH=$(git rev-parse --short "$COMMIT")
TODAY=$(date +%Y-%m-%d)

echo "Cherry-picking: $SHORT_HASH - $COMMIT_MSG"

# Ensure we're on main
CURRENT=$(git branch --show-current)
if [ "$CURRENT" != "main" ]; then
    echo "Switching to main branch..."
    git checkout main
fi

# Cherry-pick
git cherry-pick "$COMMIT"

# Update FORK_STATUS.md
if [ -f FORK_STATUS.md ]; then
    # Add entry to cherry-picked table
    sed -i "/^| 2025.*Initial fork/a | $TODAY | $SHORT_HASH | $COMMIT_MSG |" FORK_STATUS.md
    echo ""
    echo "Updated FORK_STATUS.md with cherry-pick entry"
fi

echo ""
echo "Done! Don't forget to:"
echo "  1. Test the changes"
echo "  2. Commit FORK_STATUS.md if modified"
echo "  3. Update upstream-sync if needed: git checkout upstream-sync && git reset --hard upstream/master"
