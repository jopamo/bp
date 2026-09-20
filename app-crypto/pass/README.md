# pass for bp

This is the Linux-only local fork saved in the workspace's `pass/` checkout.
Its upstream base is password-store commit
`3ca13cd8882cae4083c1c478858adbf2e82dd037`. The previously vendored main script
already included that checkout's local edits; it is not an unmodified upstream
snapshot. Sources, completions, the man page, license, and tests live in `files/`.
No source download or reference to the sibling checkout is needed to build.

The package uses bp's Bash, GnuPG, bx utilities (including grep), diffutils,
findutils, sed, procps, and util-linux's `getopt` feature. It does not need
`tree` and does not load platform override scripts. Git integration is optional.
`pass edit` uses `$EDITOR`, falling back to `vi`; provide a working editor.

Optional features:

- `X` installs xclip for X11 clipboard support.
- `qrcode` installs qrencode; terminal QR output needs no image viewer.
- The host can use `wl-copy`/`wl-paste` if installed separately; bp currently
  has no wl-clipboard package, so this is not a packaged Wayland feature.
- `importers` retains the old upstream conversion scripts as opt-in extras.
  They have format-specific interpreter/library requirements and are not
  covered by the core pass tests.

Only Bash and Fish completions are installed. Corepkg strips documentation and
Zsh completions, so the ebuild does not install those. The man page and GPL
license (`/usr/share/licenses/pass/COPYING`) remain installed.

The local failure-handling fixes keep existing ciphertext until both its
plaintext producer and GPG encryption succeed. A failed editor or
noninteractive encryption attempt fails rather than committing or retrying
forever. QR input is passed literally, including passwords such as `-n`.
`init` rejects symlinked recipient/signature output files. This does
not make an entire multi-entry `init`, copy, or move operation transactional,
and the shell path checks are not protection against concurrent hostile
modification of the store directory.

Run package tests from the bp repository root:

```sh
BP_TEST_USE=test scripts/test-ebuild app-crypto/pass/pass-20260510-r1.ebuild
```

Tests run against the script prepared for installation, with disposable stores,
Git configuration, and copies of the upstream **public test keys**. The secret
key fixtures are deliberately published test material, never real credentials.
The fixtures are not installed. Tests cover the upstream CLI suite and injected
encryption, decryption, editor, and symlink failures, plus mocked QR input.
They do not exercise a real desktop clipboard or external importers.

Keep this as a local fork: review changes explicitly and bump the package
revision/version rather than replacing it through an automatic upstream bump.
