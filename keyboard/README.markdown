# Keyboard Customization

Adds support for rebinding keys with [Karabiner-Elements][] and execute scripts
with [Hammerspoon][]. Based on [jasonrudolph/keyboard][].

[Hammerspoon]: https://github.com/Hammerspoon/hammerspoon
[jasonrudolph/keyboard]: https://github.com/jasonrudolph/keyboard
[Karabiner-Elements]: https://github.com/pqrs-org/Karabiner-Elements

## Installation

Run the setup script to install the applications and link configuration.

    bin/setup

## Usage

### Window Mode

Use `Control+s` to enable window mode, followed by a key to modify a window size
and position.

Key    | Description
------ | ------------
a      | Increase the window size by 10% of the screen size.
c      | Move window to the center of the screen.
d      | Resize window to 80% of the screen and center it.
h      | Move and resize the window to the left half of the screen.
j      | Move and resize the window to the bottom half of the screen.
k      | Move and resize the window to the top half of the screen.
l      | Move and resize the window to the right half of the screen.
return | Resize window the fill the entire screen.
s      | Decrease the window size by 10% of the screen size.

### Utilities

Shortcut    | Description
----------- | -----------
Control + ` | Reload the Hammerspoon configuration.
