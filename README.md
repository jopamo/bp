<div align="left">

[![1g4-linux](https://raw.githubusercontent.com/jopamo/bp/main/.github/bp.png)](#readme)

[![Commits](https://img.shields.io/github/commit-activity/m/jopamo/bp?label=commits&style=for-the-badge)](https://github.com/jopamo/bp/commits)
[![Last Commit](https://img.shields.io/github/last-commit/jopamo/bp/main?label=&style=for-the-badge)](https://github.com/jopamo/bp/commits)

</div>

bp is short for 'backpack' to denote it being easier to move around on various cloud services or embedded devices.

The core and GUI profiles now select the packages formerly pulled in by
`app-core/1g4-tools`. After syncing, remove the old metapackage from the world
file with `emerge --deselect app-core/1g4-tools`, then update `@world`.
On a non-GUI system, explicitly select any GUI-profile tools you want to keep
before running depclean.
