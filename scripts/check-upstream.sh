#!/bin/bash
# Check for new upstream commits in hy3
# Usage: ./scripts/check-upstream.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

cd "$REPO_DIR"

echo "Fetching upstream..."
git fetch upstream --quiet

LOCAL=$(git rev-parse upstream-sync 2>/dev/null || echo "none")
REMOTE=$(git rev-parse upstream/master 2>/dev/null || git rev-parse upstream/main 2>/dev/null)

if [ "$LOCAL" = "none" ]; then
    echo "No upstream-sync branch found. Creating..."
    git branch upstream-sync "$REMOTE"
    LOCAL="$REMOTE"
fi

if [ "$LOCAL" = "$REMOTE" ]; then
    echo "Up to date with upstream!"
    exit 0
fi

BEHIND=$(git rev-list --count "$LOCAL".."$REMOTE")
echo ""
echo "=== $BEHIND new commit(s) from upstream ==="
echo ""
git log --oneline "$LOCAL".."$REMOTE"
echo ""
echo "=== Files changed ==="
git diff --stat "$LOCAL".."$REMOTE"
echo ""
echo "To review a specific commit: git show <hash>"
echo "To cherry-pick: git checkout main && git cherry-pick <hash>"
echo "To update tracking: git checkout upstream-sync && git reset --hard upstream/master"
