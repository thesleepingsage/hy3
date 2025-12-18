# hy3 Fork Status

## Upstream
- **Repository**: [outfoxxed/hy3](https://github.com/outfoxxed/hy3)
- **Last synced**: 2025-12-14
- **Upstream HEAD**: `33fb5c0` (fix: pin 0.52.2)

## Fork Purpose
Personal fork to avoid waiting for upstream to update pins for new Hyprland releases.
See: https://github.com/outfoxxed/hy3/issues/259

## Our Modifications

| Status | Commit | Feature | Description |
|--------|--------|---------|-------------|
| ✅ | c119158 | hy3:equalize | Custom dispatcher to equalize window sizes |
| ✅ | b1322b1 | hy3:swapwindow | Address-based window swapping dispatcher |

## Cherry-picked from Upstream

| Date | Commit | Description |
|------|--------|-------------|
| 2025-12-14 | 16dae4d | Hash checking fix for Hyprland 0.52.2 (nnra6864) |

## Intentionally Skipped

| Commit | Reason |
|--------|--------|
| 33fb5c0 | Just adds commit pin - we have the actual fix (16dae4d) |

## Notes

### The 0.52.2 Issue
Hyprland 0.52.2 tag was missing `FocusState.hpp` (added post-0.52.0, not in patch releases).
- **Discussion**: https://github.com/hyprwm/Hyprland/discussions/12571
- **Issue**: https://github.com/outfoxxed/hy3/issues/259
- **Our fix**: Cherry-picked `16dae4d` which updates hash checking after Hyprland PR #12110

### Build Flags
- Production: `cmake -DCMAKE_BUILD_TYPE=Release -B build`
- Debug (skips version check): `cmake -DCMAKE_BUILD_TYPE=Debug -DHY3_NO_VERSION_CHECK=TRUE -B build`

## Branch Structure

- `personal` - Working branch with our customizations (tracks origin/personal)
- `upstream-sync` - Mirrors upstream/master for comparison
- `feat/*` - Feature branches for new work

## Sync Workflow

```bash
# 1. Fetch latest upstream
git fetch upstream

# 2. Update tracking branch
git checkout upstream-sync
git reset --hard upstream/master

# 3. Compare changes
git log --oneline personal..upstream-sync
git diff personal..upstream-sync --stat

# 4. Cherry-pick specific fixes
git checkout personal
git cherry-pick <commit-hash>

# 5. Update this file with what was picked/skipped
```

## Build & Install

```bash
# Build
cmake -B build
cmake --build build

# Install via hyprpm (if configured)
hyprpm reload

# Or manual install
sudo cp build/libhy3.so /usr/lib/hyprland/plugins/
```
