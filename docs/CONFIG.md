# hy3 Configuration Guide

hy3 is an i3/sway-like tiling layout plugin for Hyprland with support for manual tiling, tabbed groups, and autotiling.

## Enabling hy3

First, load the plugin and set hy3 as your layout:

```conf
plugin = /path/to/libhy3.so

general {
    layout = hy3
}
```

**Important:** Replace Hyprland's default dispatchers with hy3 equivalents:
- `movefocus` → `hy3:movefocus`
- `movewindow` → `hy3:movewindow`

All hy3 config options go under `plugin:hy3`:

```conf
plugin {
    hy3 {
        # options here
    }
}
```

---

## General Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `no_gaps_when_only` | int | `0` | Disable gaps when only one window is onscreen. `0` = always show gaps, `1` = hide gaps with single window, `2` = hide gaps but show window border |
| `node_collapse_policy` | int | `2` | Policy for when a node is removed leaving only a nested group. `0` = remove the nested group, `1` = keep the nested group, `2` = keep only if parent is a tab group |
| `group_inset` | int | `10` | Offset from group split direction when only one window is in a group |
| `tab_first_window` | bool | `false` | Automatically create a tab group for the first window spawned in a workspace |

---

## Tab/Group Settings

The `tabs:` section controls the appearance of tabbed window groups.

### Geometry

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `tabs:height` | int | `22` | Height of the tab bar |
| `tabs:padding` | int | `6` | Padding between the tab bar and its focused node |
| `tabs:from_top` | bool | `false` | Tab bar animates in/out from the top instead of below the window |
| `tabs:radius` | int | `6` | Corner radius for tab bar segments |
| `tabs:border_width` | int | `2` | Tab bar border width |

### Text

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `tabs:render_text` | bool | `true` | Render window title on the tab bar |
| `tabs:text_center` | bool | `true` | Center the window title |
| `tabs:text_font` | string | `"Sans"` | Font to render the window title with |
| `tabs:text_height` | int | `8` | Height of the window title |
| `tabs:text_padding` | int | `3` | Left padding of the window title |

### Appearance

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `tabs:opacity` | float | `1.0` | Opacity multiplier for tabs (applies to blur and colors) |
| `tabs:blur` | bool | `true` | Blur behind tab backgrounds (only visible when colors are not opaque) |

### Colors

Colors use `rgba()` format (e.g., `rgba(33ccff40)`).

**Active Tab** (focused window on focused monitor):
| Option | Default | Description |
|--------|---------|-------------|
| `tabs:col.active` | `rgba(33ccff40)` | Background color |
| `tabs:col.active.border` | `rgba(33ccffee)` | Border color |
| `tabs:col.active.text` | `rgba(ffffffff)` | Text color |

**Active on Alt Monitor** (focused window on unfocused monitor):
| Option | Default | Description |
|--------|---------|-------------|
| `tabs:col.active_alt_monitor` | `rgba(60606040)` | Background color |
| `tabs:col.active_alt_monitor.border` | `rgba(808080ee)` | Border color |
| `tabs:col.active_alt_monitor.text` | `rgba(ffffffff)` | Text color |

**Focused Tab** (focused node in unfocused container):
| Option | Default | Description |
|--------|---------|-------------|
| `tabs:col.focused` | `rgba(60606040)` | Background color |
| `tabs:col.focused.border` | `rgba(808080ee)` | Border color |
| `tabs:col.focused.text` | `rgba(ffffffff)` | Text color |

**Inactive Tab**:
| Option | Default | Description |
|--------|---------|-------------|
| `tabs:col.inactive` | `rgba(30303020)` | Background color |
| `tabs:col.inactive.border` | `rgba(606060aa)` | Border color |
| `tabs:col.inactive.text` | `rgba(ffffffff)` | Text color |

**Urgent Tab** (window requesting attention):
| Option | Default | Description |
|--------|---------|-------------|
| `tabs:col.urgent` | `rgba(ff223340)` | Background color |
| `tabs:col.urgent.border` | `rgba(ff2233ee)` | Border color |
| `tabs:col.urgent.text` | `rgba(ffffffff)` | Text color |

**Locked Tab** (tab lock enabled):
| Option | Default | Description |
|--------|---------|-------------|
| `tabs:col.locked` | `rgba(90903340)` | Background color |
| `tabs:col.locked.border` | `rgba(909033ee)` | Border color |
| `tabs:col.locked.text` | `rgba(ffffffff)` | Text color |

---

## Autotiling

Autotiling automatically creates groups based on window dimensions.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `autotile:enable` | bool | `false` | Enable autotiling |
| `autotile:ephemeral_groups` | bool | `true` | Make autotile-created groups ephemeral |
| `autotile:trigger_width` | int | `0` | If window would be squished smaller than this width, create vertical split. `-1` = never split vertically, `0` = always split vertically, `<n>` = pixel width threshold |
| `autotile:trigger_height` | int | `0` | If window would be squished smaller than this height, create horizontal split. `-1` = never split horizontally, `0` = always split horizontally, `<n>` = pixel height threshold |
| `autotile:workspaces` | string | `"all"` | Space or comma separated list of workspace IDs. Prefix with `not:` to exclude (e.g., `not:1,2` enables on all except 1 and 2) |

---

## Example Configuration

```conf
plugin {
    hy3 {
        no_gaps_when_only = 1
        node_collapse_policy = 2
        group_inset = 10
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

            opacity = 1.0
            blur = true

            col.active = rgba(33ccff40)
            col.active.border = rgba(33ccffee)
            col.active.text = rgba(ffffffff)

            col.focused = rgba(60606040)
            col.focused.border = rgba(808080ee)
            col.focused.text = rgba(ffffffff)

            col.inactive = rgba(30303020)
            col.inactive.border = rgba(606060aa)
            col.inactive.text = rgba(ffffffff)

            col.urgent = rgba(ff223340)
            col.urgent.border = rgba(ff2233ee)
            col.urgent.text = rgba(ffffffff)

            col.locked = rgba(90903340)
            col.locked.border = rgba(909033ee)
            col.locked.text = rgba(ffffffff)
        }

        autotile {
            enable = false
            ephemeral_groups = true
            trigger_width = 0
            trigger_height = 0
            workspaces = all
        }
    }
}
```

---

# Dispatchers

All hy3 dispatchers are prefixed with `hy3:`. Use them with `bind`:

```conf
bind = $mod, key, hy3:dispatcher, args
```

---

## Group Management

### `hy3:makegroup`
Make a vertical/horizontal split or tab group.

**Syntax:** `hy3:makegroup, <h | v | opposite | tab>, [toggle], [ephemeral | force_ephemeral]`

| Argument | Description |
|----------|-------------|
| `h` | Horizontal split group |
| `v` | Vertical split group |
| `tab` | Tabbed group |
| `opposite` | Opposite of current parent's orientation |
| `toggle` | If focused node is the only child of a parent matching the type, remove that parent instead |
| `ephemeral` | Group will be removed once it contains only one node (doesn't affect existing groups) |
| `force_ephemeral` | Same as ephemeral, but also converts existing single-window groups |

**Examples:**
```conf
bind = $mod, g, hy3:makegroup, tab
bind = $mod, v, hy3:makegroup, v
bind = $mod, b, hy3:makegroup, h
bind = $mod SHIFT, g, hy3:makegroup, tab, toggle
bind = $mod, o, hy3:makegroup, opposite, ephemeral
```

### `hy3:changegroup`
Change the group the node belongs to, to a different layout.

**Syntax:** `hy3:changegroup, <h | v | tab | untab | toggletab | opposite>`

| Argument | Description |
|----------|-------------|
| `h` | Change to horizontal split |
| `v` | Change to vertical split |
| `tab` | Change to tabbed |
| `untab` | Untab the group if it was previously tabbed |
| `toggletab` | Untab if tabbed, tab if untabbed |
| `opposite` | Toggle between horizontal and vertical (if not tabbed) |

**Examples:**
```conf
bind = $mod, t, hy3:changegroup, toggletab
bind = $mod CTRL, h, hy3:changegroup, h
bind = $mod CTRL, v, hy3:changegroup, v
```

### `hy3:setephemeral`
Change the ephemerality of the group the node belongs to.

**Syntax:** `hy3:setephemeral, <true | false>`

```conf
bind = $mod, e, hy3:setephemeral, true
```

---

## Focus Navigation

### `hy3:movefocus`
Move the focus left, up, down, or right.

**Syntax:** `hy3:movefocus, <l | u | d | r | left | down | up | right>, [visible], [warp | nowarp]`

| Argument | Description |
|----------|-------------|
| `l`, `left` | Focus left |
| `r`, `right` | Focus right |
| `u`, `up` | Focus up |
| `d`, `down` | Focus down |
| `visible` | Only move between visible nodes, not hidden tabs |
| `warp` | Warp mouse to selected window even if `general:no_cursor_warps` is true |
| `nowarp` | Don't warp mouse even if `general:no_cursor_warps` is false |

**Examples:**
```conf
bind = $mod, h, hy3:movefocus, l
bind = $mod, l, hy3:movefocus, r
bind = $mod, k, hy3:movefocus, u
bind = $mod, j, hy3:movefocus, d
bind = $mod SHIFT, h, hy3:movefocus, l, visible
```

### `hy3:changefocus`
Change focus within the node hierarchy.

**Syntax:** `hy3:changefocus, <top | bottom | raise | lower | tab | tabnode>`

| Argument | Description |
|----------|-------------|
| `top` | Focus all nodes in the workspace |
| `bottom` | Focus the single root selection window |
| `raise` | Raise focus one level |
| `lower` | Lower focus one level |
| `tab` | Raise focus to the nearest tab |
| `tabnode` | Raise focus to the nearest node under the tab |

**Examples:**
```conf
bind = $mod, a, hy3:changefocus, raise
bind = $mod SHIFT, a, hy3:changefocus, lower
```

### `hy3:focustab`
Navigate between tabs in a tab group.

**Syntax:** `hy3:focustab, <l | r | left | right | index, <index>>, [prioritize_hovered | require_hovered], [wrap]`

| Argument | Description |
|----------|-------------|
| `l`, `left` | Focus previous tab |
| `r`, `right` | Focus next tab |
| `index, <n>` | Select the nth tab (0-indexed) |
| `prioritize_hovered` | Prioritize tab group under mouse when stacked; use lowest if none hovered |
| `require_hovered` | Only affect tab group under mouse; do nothing if none hovered |
| `wrap` | Wrap to opposite end of tab bar when moving off the edge |

**Examples:**
```conf
bind = $mod, Tab, hy3:focustab, r, wrap
bind = $mod SHIFT, Tab, hy3:focustab, l, wrap
bind = $mod, 1, hy3:focustab, index, 0
bind = $mod, 2, hy3:focustab, index, 1
```

### `hy3:togglefocuslayer`
Toggle focus between tiled and floating layers.

**Syntax:** `hy3:togglefocuslayer, [nowarp]`

| Argument | Description |
|----------|-------------|
| `nowarp` | Do not warp mouse to newly focused window |

```conf
bind = $mod, space, hy3:togglefocuslayer
```

### `hy3:warpcursor`
Warp the cursor to the center of the focused node.

```conf
bind = $mod, w, hy3:warpcursor
```

---

## Window Movement

### `hy3:movewindow`
Move a window left, up, down, or right.

**Syntax:** `hy3:movewindow, <l | u | d | r | left | down | up | right>, [once], [visible]`

| Argument | Description |
|----------|-------------|
| `l`, `left` | Move left |
| `r`, `right` | Move right |
| `u`, `up` | Move up |
| `d`, `down` | Move down |
| `once` | Only move directly to neighboring group, without entering subgroups |
| `visible` | Only move between visible nodes, not hidden tabs |

**Examples:**
```conf
bind = $mod SHIFT, h, hy3:movewindow, l
bind = $mod SHIFT, l, hy3:movewindow, r
bind = $mod SHIFT, k, hy3:movewindow, u
bind = $mod SHIFT, j, hy3:movewindow, d
bind = $mod CTRL SHIFT, h, hy3:movewindow, l, once
```

### `hy3:movetoworkspace`
Move the active node to the given workspace.

**Syntax:** `hy3:movetoworkspace, <workspace>, [follow], [warp | nowarp]`

| Argument | Description |
|----------|-------------|
| `<workspace>` | Target workspace (number, name, or special) |
| `follow` | Change focus to target workspace after moving |
| `warp` | Warp mouse to selected window even if `general:no_cursor_warps` is true |
| `nowarp` | Don't warp mouse even if `general:no_cursor_warps` is false |

**Examples:**
```conf
bind = $mod SHIFT, 1, hy3:movetoworkspace, 1
bind = $mod SHIFT, 2, hy3:movetoworkspace, 2, follow
bind = $mod SHIFT, s, hy3:movetoworkspace, special:scratchpad
```

---

## Window Actions

### `hy3:killactive`
Close all windows in the focused node.

```conf
bind = $mod, q, hy3:killactive
```

### `hy3:expand` ⚠️ ALPHA QUALITY
Expand or shrink the current node to cover other nodes.

**Syntax:** `hy3:expand, <expand | shrink | base | maximize | fullscreen>, [fullscreen_mode]`

| Mode | Description |
|------|-------------|
| `expand` | Expand by one node |
| `shrink` | Shrink by one node |
| `base` | Undo all expansions |
| `maximize` | Maximize within parent |
| `fullscreen` | Fullscreen the window |

| Fullscreen Mode | Description |
|-----------------|-------------|
| `intermediate_maximize` | Maximize before fullscreen (default) |
| `fullscreen_maximize` | Treat maximize as fullscreen |
| `maximize_only` | Only allow maximize, not fullscreen |

**Examples:**
```conf
bind = $mod, f, hy3:expand, fullscreen
bind = $mod, m, hy3:expand, maximize
bind = $mod, equal, hy3:expand, expand
bind = $mod, minus, hy3:expand, shrink
bind = $mod, 0, hy3:expand, base
```

### `hy3:setswallow` ⚠️ ALPHA QUALITY
Set the containing node's window swallow state.

**Syntax:** `hy3:setswallow, <true | false | toggle>`

```conf
bind = $mod, s, hy3:setswallow, toggle
```

### `hy3:locktab`
Lock the current tab, making it behave like a node.

**Syntax:** `hy3:locktab, [lock | unlock]`

| Argument | Description |
|----------|-------------|
| (none) | Toggle lock state |
| `lock` | Lock the tab |
| `unlock` | Unlock the tab |

```conf
bind = $mod, x, hy3:locktab
```

---

## Debugging

### `hy3:debugnodes`
Print the node tree into the Hyprland log.

```conf
bind = $mod SHIFT, d, hy3:debugnodes
```

---

## Complete Keybind Example

```conf
# Focus (replaces movefocus)
bind = $mod, h, hy3:movefocus, l
bind = $mod, j, hy3:movefocus, d
bind = $mod, k, hy3:movefocus, u
bind = $mod, l, hy3:movefocus, r

# Move windows (replaces movewindow)
bind = $mod SHIFT, h, hy3:movewindow, l
bind = $mod SHIFT, j, hy3:movewindow, d
bind = $mod SHIFT, k, hy3:movewindow, u
bind = $mod SHIFT, l, hy3:movewindow, r

# Groups
bind = $mod, g, hy3:makegroup, tab
bind = $mod, v, hy3:makegroup, v
bind = $mod, b, hy3:makegroup, h
bind = $mod, t, hy3:changegroup, toggletab
bind = $mod, a, hy3:changefocus, raise
bind = $mod SHIFT, a, hy3:changefocus, lower

# Tabs
bind = $mod, Tab, hy3:focustab, r, wrap
bind = $mod SHIFT, Tab, hy3:focustab, l, wrap

# Actions
bind = $mod, q, hy3:killactive
bind = $mod, f, hy3:expand, fullscreen
bind = $mod, m, hy3:expand, maximize
bind = $mod, e, hy3:expand, base

# Workspaces
bind = $mod SHIFT, 1, hy3:movetoworkspace, 1
bind = $mod SHIFT, 2, hy3:movetoworkspace, 2
bind = $mod SHIFT, 3, hy3:movetoworkspace, 3
```
