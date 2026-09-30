# xvfb-run

This is 1g4 Linux's local fork of `debian/local/xvfb-run` from
`xorg-server_21.1.24-1.diff.gz`:
<https://deb.debian.org/debian/pool/main/x/xorg-server/xorg-server_21.1.24-1.diff.gz>.
Branden Robinson and Jeff Licquia wrote the original script with sponsorship
from Progeny Linux Systems. The script and manual are licensed under GPL-2 or
later; `files/LICENSE` contains GPL version 2.

The ebuild installs local files without downloading Debian sources. Bump the
package version or revision when changing this fork.

The wrapper uses 1g4's `bx` utilities, util-linux's `getopt` and `mcookie`,
`xauth`, and `xorg-server[xvfb]`. It retains the `xvfb-run` command-line options
and Xvfb's SIGUSR1 readiness handshake. `--wait` is accepted but ignored.

Local changes remove terminal-width formatting, validate display numbers,
apply automatic display selection after option parsing, quote authority paths,
disable pathname expansion in server arguments, and stop after failed startup
retries. Cleanup stops and waits for Xvfb before removing temporary files and
preserves the command's exit status.

Run the focused tests without an installed X server:

```sh
sh xgui-tools/xvfb-run/files/test-xvfb-run xgui-tools/xvfb-run/files/xvfb-run
scripts/test-ebuild xgui-tools/xvfb-run/xvfb-run-20260930.ebuild
```
