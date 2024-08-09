# Hammerspoon

My custom [Hammerspoon][] configuration.

## Installation

Run the setup script to install the application and link the configuration.

    bin/setup

## Customizations

### Keyboard

Adds support for moving and resizing windows with Hammerspoon. Based on
[jasonrudolph/keyboard][].

#### Usage

Go to `System Preferences -> Keyboard -> Modifier Keys` and to change `Caps
Lock` to send `Control` instead.

##### Window Mode

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

##### Utilities

Shortcut    | Description
----------- | -----------
Control + ` | Reload the Hammerspoon configuration.

[Hammerspoon]: https://github.com/Hammerspoon/hammerspoon
[jasonrudolph/keyboard]: https://github.com/jasonrudolph/keyboard
