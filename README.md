<div align="left">

[![1g4-linux](https://raw.githubusercontent.com/jopamo/bp/main/.github/bp.png)](#readme)

[![Commits](https://img.shields.io/github/commit-activity/m/jopamo/bp?label=commits&style=for-the-badge)](https://github.com/jopamo/bp/commits)
[![Last Commit](https://img.shields.io/github/last-commit/jopamo/bp/main?label=&style=for-the-badge)](https://github.com/jopamo/bp/commits)

</div>

bp is short for 'backpack' to denote it being easier to move around on various cloud services or embedded devices.

## Features
* supported arches: amd64 arm64
* supported libc: glibc musl
* supported ssl: vesk
* supported curses: ncurses netbsd-curses
* bootstrap golang toolchain from source
* bootstrap rust toolchain from source

## bx browser compatibility identities

`app-core/bx` obtains Chrome-family and Firefox versions through
`browser-user-agent.eclass`. Installed stable packages take precedence over
release ebuilds in this repository. Chrome-family selection prefers
`bin/google-chrome`, then `bin/chromium`; Firefox uses `xgui-app/firefox`.
Unstable, nightly, prerelease, and live versions are not automatic candidates.
No browser dependency is added. Missing families disable their Mira profiles.

The ebuild passes complete release versions to Meson, which emits only the
major version in compatibility User-Agent strings. User `MYMESONARGS` comes
last, so `-Dmira_chrome_version=155` overrides discovery and
`-Dmira_firefox_version=` disables Firefox explicitly.

Run `scripts/test-browser-user-agent` for isolated resolver and ebuild-argument
coverage without installed browsers.

## Check dependency resolution without building

Run as your regular user, without `sudo`, from this checkout:

```sh
scripts/check-tree --jobs 8 --cache-dir "$HOME/.cache/bp-resolver"
```

This runs `emerge --pretend --emptytree` independently for **every ebuild
version**, including build dependencies. One combined emerge invocation would
incorrectly require mutually exclusive packages to coexist. Run against a
stable checkout; do not bump packages concurrently.

Configuration, logs, and `summary.tsv` are retained in the printed
`/tmp/bp-check-tree.*` directory. The metadata cache is private to the run
unless `--cache-dir` is supplied. The helper never enables fetching, building,
package moves, binary packages, or automatic unmask/configuration changes.
It ignores the host's `@world` selection and accepts all licenses for this
resolver check; profile masks, keywords, and USE constraints still apply.

Narrow a check or change its profile/USE settings:

```sh
scripts/check-tree dev-pypi/uv-build app-core/1g4-tools
scripts/check-tree rust-crates/serde_derive_internals/serde_derive_internals-0.30.0.ebuild
BP_TEST_USE="netbsd-curses" scripts/check-tree --profile core/amd64/musl
scripts/check-tree --timeout 600 --output /tmp/bp-resolve-retry dev-pypi/uv-build
```

Exit status is zero only when every selected ebuild resolves. Failures and
timeouts remain in the report; an interrupted run is incomplete. List the
unsuccessful targets and their log paths with:

```sh
awk -F '\t' 'NR > 1 && $2 != "PASS" { print $1, $2, $5 }' /tmp/bp-check-tree.XXXXXX/summary.tsv
```

The private configuration can also be reused for a manual, regular-user
emerge check:

```sh
COREPKG_CONFIGROOT=/tmp/bp-check-tree.XXXXXX/config ROOT=/ SYSROOT=/ EPREFIX= \
emerge --ignore-default-opts --pretend --emptytree --with-bdeps=y \
  --ignore-world=y --complete-graph-if-new-use=n --complete-graph-if-new-ver=n \
  --package-moves=n --autounmask=n --autounmask-write=n --usepkg=n --getbinpkg=n \
  dev-pypi/uv-build
```

Keep `--pretend` and `--package-moves=n`: pretend mode alone does not disable
Corepkg's package-move maintenance. `ROOT=/` avoids loading a second, possibly
invalid host build-root profile. The installed-package database can still be
consulted read-only; this is not an empty-root bootstrap test.

This catches missing dependency ebuilds, invalid metadata, masks,
unsatisfied USE requirements, blockers, and slot conflicts for the selected
profile and USE settings. It does not test every USE combination, downloads,
`pkg_pretend`, configuration, compilation, or installation. For those phases,
use the unprivileged `scripts/test-ebuild` helper described in [HACKING.md](HACKING.md).

## Rust's LLVM runtime

Source Rust packages copy the LLVM shared libraries named by their installed
ELF dependencies into `/usr/lib/rust/llvm`. The install helper follows
transitive LLVM dependencies, gives the copies private SONAMEs, and rewrites
their consumers to use relative RUNPATHs. LLVM upgrades can then replace the
system compiler libraries without removing the copies Rust needs.

Platform runtimes such as libc++, libstdc++ and libunwind remain system
dependencies, and LLVM is still required for the system `rust-lld` link.
Rebuild Rust to refresh its private LLVM compiler-library copies;
upgrading LLVM alone does not update them. The prebuilt `rust-bin` package is
unchanged. Run `scripts/test-rust-bundle-llvm` for the focused packaging tests.
