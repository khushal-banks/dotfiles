# tofi

[default](https://github.com/philj56/tofi/blob/master/doc/config)
 | [guide](https://github.com/philj56/tofi/blob/master/doc/tofi.5.md)
 | [manpage](https://github.com/philj56/tofi/blob/master/doc/tofi.1.md)

## Install tofi

```bash
yay -S tofi-git
```

### ⚠️ Note

It is highly recommended to use **tofi-git**.

👇🏼 or else you may have to do following:

- removing new configuration parameters
- check errors by running `tofi` or `tofi-drun` on cli

## Usage

- Copy tofi directory to `~/.config/`
- Copy scripts directory to `~/scripts/`

## Hyprland Configuration

```hyprlang
# Set your menu program in hyprland.conf
$menu = tofi-drun

# Set a keybinding for hyprland-uwsm.desktop wayland-sesion
bind = $mainMod, Space, exec, pkill $menu || uwsm app -- $menu
```

Or alternatively, if you are **not using uwsm** then,

```hyprlang
# Set a keybinding for hyprland.desktop wayland-session
bind = $mainMod, Space, exec, pkill $menu || $menu
```
