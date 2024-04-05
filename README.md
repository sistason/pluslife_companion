# Pluslife Companion

Uses a Raspberry Pi (>=2) to interface with the [Pluslife NAAT](virus.sucks/pluslife) in order to streamline testing.

## Components

The setup consists of the following parts:

Hardware:
- Raspberry Pi. 2++ (armv7++), as a Pi 1 a) has problems with RAM for running chrome and b) difficulties running the display
- A 3.5 inch touchscreen (XPT2046 / ADS7846). 480x320 is too small for comfort, but its cheap and works (with hacks)
- A hardware button on GPIO to press `Return`, as the 320px are too small in chrome dialogs to confirm serial port connections...

Software:
- Any Raspbian working for your Raspberry Pi.
- The display drivers (https://github.com/goodtdt/LCD-Show)
- Hardware button config in /boot/config.txt
- A saved version of the Pluslife Analyzer website which this project wraps in Hardware.
- Chromium.desktop application shortcut with autostart
- disable energy savings

## Ansible

This uses ansible to automate deployment on multiple Raspberry Pi using the same configuration.

