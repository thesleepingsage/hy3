# hy3 (Personal Fork)

Personal fork of [outfoxxed/hy3](https://github.com/outfoxxed/hy3) - i3/sway-like tiling for Hyprland.

See [FORK_STATUS.md](./FORK_STATUS.md) for upstream sync info.

---

## Quick Reference

```conf
# Enable in hyprland.conf
general:layout = hy3

# Replace default dispatchers
movefocus  -> hy3:movefocus
movewindow -> hy3:movewindow
```

---

## Versioning

- Tagged releases match Hyprland versions (format: `hl{version}`)
- Master branch tracks Hyprland master
- **Mismatched versions will fail to build or load**

---

## Installation

### hyprpm

```bash
hyprpm add https://github.com/outfoxxed/hy3
hyprpm update      # update
hyprpm update -f   # force header refresh if needed
```

Add to `hyprland.conf`:
```conf
exec-once = hyprpm reload -n
```

### Manual Build

```bash
cmake -DCMAKE_BUILD_TYPE=Release -B build
cmake --build build
# Result: build/libhy3.so
```

---

## Config Fields

```conf
plugin {
  hy3 {
    # 0 = always gaps, 1 = no gaps single window, 2 = no gaps + no border
    no_gaps_when_only = 0

    # 0 = remove nested groups, 1 = keep, 2 = keep if parent is tab
    node_collapse_policy = 2

    # Offset when single window in group
    group_inset = 10

    # Auto-create tab group for first window
    tab_first_window = false

    tabs {
      height = 22
      padding = 6
      from_top = false
      radius = 6
      border_width = 2
      render_text = true
      text_center = true
      text_font = Sans
      text_height = 8
      text_padding = 3

      # Active (focused monitor)
      col.active = rgba(33ccff40)
      col.active.border = rgba(33ccffee)
      col.active.text = rgba(ffffffff)

      # Active (unfocused monitor)
      col.active_alt_monitor = rgba(60606040)
      col.active_alt_monitor.border = rgba(808080ee)
      col.active_alt_monitor.text = rgba(ffffffff)

      # Focused (in unfocused container)
      col.focused = rgba(60606040)
      col.focused.border = rgba(808080ee)
      col.focused.text = rgba(ffffffff)

      # Inactive
      col.inactive = rgba(30303020)
      col.inactive.border = rgba(606060aa)
      col.inactive.text = rgba(ffffffff)

      # Urgent
      col.urgent = rgba(ff223340)
      col.urgent.border = rgba(ff2233ee)
      col.urgent.text = rgba(ffffffff)

      # Locked
      col.locked = rgba(90903340)
      col.locked.border = rgba(909033ee)
      col.locked.text = rgba(ffffffff)

      blur = true
      opacity = 1.0
    }

    autotile {
      enable = false
      ephemeral_groups = true
      trigger_width = 0   # 0 = always split, -1 = never, <n> = at n pixels
      trigger_height = 0
      workspaces = all    # or "1 2 3" or "not:1,2"
    }
  }
}
```

---

## Dispatchers

### Groups & Splits

| Dispatcher | Args | Description |
|------------|------|-------------|
| `hy3:makegroup` | `<h\|v\|opposite\|tab>, [toggle], [ephemeral\|force_ephemeral]` | Create split/tab group |
| `hy3:changegroup` | `<h\|v\|tab\|untab\|toggletab\|opposite>` | Change group layout |
| `hy3:setephemeral` | `<true\|false>` | Set group ephemerality |

### Focus & Navigation

| Dispatcher | Args | Description |
|------------|------|-------------|
| `hy3:movefocus` | `<l\|u\|d\|r>, [visible], [warp\|nowarp]` | Move focus |
| `hy3:warpcursor` | | Warp cursor to focused node |
| `hy3:changefocus` | `<top\|bottom\|raise\|lower\|tab\|tabnode>` | Change focus level |
| `hy3:togglefocuslayer` | `[nowarp]` | Toggle tiled/floating focus |

### Window Movement

| Dispatcher | Args | Description |
|------------|------|-------------|
| `hy3:movewindow` | `<l\|u\|d\|r>, [once], [visible]` | Move window |
| `hy3:movetoworkspace` | `<ws>, [follow, [warp\|nowarp]]` | Move to workspace |

### Tabs

| Dispatcher | Args | Description |
|------------|------|-------------|
| `hy3:focustab` | `[l\|r\|index,<n>], [prioritize_hovered\|require_hovered], [wrap]` | Navigate tabs |
| `hy3:locktab` | `[lock\|unlock]` | Lock tab as node |

### Other

| Dispatcher | Args | Description |
|------------|------|-------------|
| `hy3:killactive` | | Close all windows in node |
| `hy3:debugnodes` | | Print node tree to log |
| `hy3:setswallow` | `<true\|false\|toggle>` | Window swallowing (alpha) |
| `hy3:expand` | `<expand\|shrink\|base>` | Expand node coverage (alpha) |

---

## Dispatcher Details

### hy3:makegroup
- `toggle` - remove parent if node is only child of matching type
- `ephemeral` - group removed when down to one node
- `force_ephemeral` - ephemeral + converts existing single-window groups

### hy3:changegroup
- `untab` - untab if tabbed
- `toggletab` - toggle tab state
- `opposite` - toggle h/v if not tabbed

### hy3:movefocus / hy3:movewindow
- `visible` - skip hidden tabs
- `once` - don't enter subgroups
- `warp` / `nowarp` - override cursor warp setting

### hy3:changefocus
- `top` - focus entire workspace
- `bottom` - focus single window
- `raise` / `lower` - move focus level
- `tab` / `tabnode` - focus nearest tab/node under tab

### hy3:focustab
- `prioritize_hovered` - prefer tab group under mouse
- `require_hovered` - only affect hovered tab group
- `wrap` - wrap at tab bar ends

---

## Example Keybinds

```conf
$mod = SUPER

# Splits
bind = $mod, v, hy3:makegroup, v
bind = $mod, h, hy3:makegroup, h
bind = $mod, t, hy3:makegroup, tab

# Focus
bind = $mod, left, hy3:movefocus, l
bind = $mod, right, hy3:movefocus, r
bind = $mod, up, hy3:movefocus, u
bind = $mod, down, hy3:movefocus, d

# Move
bind = $mod SHIFT, left, hy3:movewindow, l
bind = $mod SHIFT, right, hy3:movewindow, r
bind = $mod SHIFT, up, hy3:movewindow, u
bind = $mod SHIFT, down, hy3:movewindow, d

# Tabs
bind = $mod, tab, hy3:focustab, r, wrap
bind = $mod SHIFT, tab, hy3:focustab, l, wrap

# Focus level
bind = $mod, a, hy3:changefocus, raise
bind = $mod SHIFT, a, hy3:changefocus, lower
```

---

## Debugging

```bash
# Print node structure
hyprctl dispatch hy3:debugnodes

# Check logs
grep hy3 ~/.local/share/hyprland/hyprland.log
```
