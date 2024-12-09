# tofi

[config](https://github.com/philj56/tofi/blob/master/doc/config)
 | [guide](https://github.com/philj56/tofi/blob/master/doc/tofi.5.md)
 | [manpage](https://github.com/philj56/tofi/blob/master/doc/tofi.1.md)

### Install tofi

It is highly recommended to use **tofi-git**, or else you may have to do some tweaks on your own.
```
yay -S tofi-git
```

### Usage

- Copy tofi directory to `~/.config/`
- Test tofi with `tofi-drun` command
- Switch tofi styles with [`tofiswitch`](https://github.com/Peaceful-Times/dotfiles/blob/devel/scripts/tofiswitch.sh?plain=1#L3) script

### Hyprland Configuration

```
# Set your menu program in hyprland.conf
$menu = tofi-drun

# Set a keybinding for hyprland-uwsm.desktop wayland-sesion
bind = $mainMod, Space, exec, pkill $menu || uwsm app -- $menu
```

Or alternatively, if you are **not using uwsm** then,
```
# Set a keybinding for hyprland.desktop wayland-session
bind = $mainMod, Space, exec, pkill $menu || $menu
```
