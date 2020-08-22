# After install

Get [dmenu](https://git.suckless.org/dmenu) and [xkblayout-state](https://github.com/nonpop/xkblayout-state.git)

## Natural scrolling and tap to click touchpad

### `/usr/share/X11/xorg.conf.d/40-libinput.conf`

```
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
		Option "Tapping" "true"
		Option "TappingDrag" "true"
		Option "NaturalScrolling" "true"
        Driver "libinput"
EndSection
```

## Keyboard

### `/etc/default/keyboard`

```
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="latitude"
XKBLAYOUT="us,is"
XKBVARIANT=""
XKBOPTIONS="grp:alt_shift_toggle,grp_led:scroll"

BACKSPACE="guess"
```

Then run
```sudo dpkg-reconfigure keyboard-configuration``` 
## Suspend-then-hibernate

### `/etc/systemd/logind.conf`

```
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.
#
# Entries in this file show the compile time defaults.
# You can change settings by editing this file.
# Defaults can be restored by simply deleting this file.
#
# See logind.conf(5) for details.

[Login]
#NAutoVTs=6
#ReserveVT=6
#KillUserProcesses=no
#KillOnlyUsers=
#KillExcludeUsers=root
#InhibitDelayMaxSec=5
#HandlePowerKey=poweroff
#HandleSuspendKey=suspend
#HandleHibernateKey=hibernate
HandleLidSwitch=suspend-then-hibernate
#HandleLidSwitchExternalPower=suspend
#HandleLidSwitchDocked=ignore
#PowerKeyIgnoreInhibited=no
#SuspendKeyIgnoreInhibited=no
#HibernateKeyIgnoreInhibited=no
#LidSwitchIgnoreInhibited=yes
#HoldoffTimeoutSec=30s
#IdleAction=ignore
#IdleActionSec=30min
#RuntimeDirectorySize=10%
#RemoveIPC=yes
#InhibitorsMax=8192
#SessionsMax=8192
```

### `/etc/systemd/sleep.conf`

```
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.
#
# Entries in this file show the compile time defaults.
# You can change settings by editing this file.
# Defaults can be restored by simply deleting this file.
#
# See systemd-sleep.conf(5) for details

[Sleep]
AllowSuspend=yes
AllowHibernation=yes
AllowSuspendThenHibernate=yes
#AllowHybridSleep=yes
#SuspendMode=
#SuspendState=mem standby freeze
#HibernateMode=platform shutdown
#HibernateState=disk
#HybridSleepMode=suspend platform shutdown
#HybridSleepState=disk
HibernateDelaySec=60min
```

## Lock after suspend

### `/lib/systemd/system/resume.service`

```
[Unit]
Description=User resume actions
Before=sleep.target

[Service]
User=atli
Type=forking
Environment=DISPLAY=:0
ExecStart=/home/atli/bin/lock

[Install]
WantedBy=sleep.target
```
```
systemctl enable resume.service
systemctl start resume.service
```

## Backlight

```
/etc/X11/xorg.conf.d/20-intel.conf
Section "Device"
    Identifier  "Intel Graphics" 
    Driver      "intel"
    Option      "Backlight"  "intel_backlight"
EndSection
```

## autorandr

install autorandr

### Set default profile

Example `~/.config/autorandr/settings.ini`
```
[config]
default=Default-profile
```

Save other profiles
`autorandr --save name-of-new-profile`
