# ff2mpv native host

This is bp's Linux-native-host fork of
<https://github.com/woodruffw/ff2mpv>, copied from commit
`b21401d3295af9c7a6177a6d76725381a5bf33ef` (extension version 6.0.0).
The Python host, Firefox native-messaging manifest, and full upstream license
are kept in `files/`. There is no source download or automatic upstream bump;
changes to this local fork need a package version or revision bump.

The browser extension is **not** bundled. Install ff2mpv from
<https://addons.mozilla.org/en-US/firefox/addon/ff2mpv/>.
Its ID remains `ff2mpv@yossarian.net`; the host manifest still permits only that
extension. This package does not register a Chromium host.

Local changes:

- Require the Python interpreter and `mpv[cli,lua]`, which supplies the yt-dlp
  runtime dependency.
- Register `/usr/bin/ff2mpv.py` and launch `/usr/bin/mpv`.
- Give mpv a new session and disconnect all three standard streams so it
  cannot retain or corrupt Firefox's native-messaging pipes.
- Accept one framed JSON request, limited to 1 MiB, with a nonempty string
  `url` and optional string-list `options`. Preserve profile options as argv
  entries and put the URL after `--`; no shell is involved.
- Exit quietly on EOF. Reject malformed requests and report launch errors on
  stderr without acknowledging success.

The upstream license is **MIT with additional military and law-enforcement
restrictions**, not plain MIT. Its full text is also registered as
`licenses/ff2mpv` and installed at `/usr/share/licenses/ff2mpv/LICENSE`.

Run the host tests from the repository root:

```sh
python3 -B xgui-app/ff2mpv/files/test_ff2mpv.py
scripts/test-ebuild xgui-app/ff2mpv/ff2mpv-20260920.ebuild
```
