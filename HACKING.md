# Hacking on bp

`bp` is a Corepkg package repository. Run package commands from this repository,
and never edit generated build directories.

## Testing an ebuild without privileges

Do not run `ebuild` directly against the host configuration. The host
`/etc/corepkg/make.profile`, `/var/tmp/corepkg`, distfiles, and package output
may be missing, stale, or writable only by root.

Use the repository helper instead. From the distro workspace root:

```sh
./bp/scripts/test-ebuild lib-print/cups/cups-2.4.20260818.ebuild
```

From inside `bp`, omit the leading `./bp/`. Do not use `sudo`; the helper is
deliberately built to run as the invoking user.

The helper:

- points Corepkg at this checkout through an isolated `PORTAGE_CONFIGROOT`
- selects `profiles/core/<host-arch>/<host-libc>`
- uses a user-owned temporary `ROOT`, build directory, distfiles directory,
  and package directory
- enables Corepkg's unprivileged mode
- initializes the compatibility runtime state still required by Corepkg's
  direct ebuild frontend during `src_install` and temporary-root merge
- runs `clean unpack prepare configure compile test merge`
- merges the completed image into the temporary `ROOT`, including package
  install hooks and its VDB record
- verifies that the merged package has a nonempty VDB `CONTENTS` record
- cleans the temporary root on exit

It does not resolve or install dependencies. Build and test dependencies must
already exist on the host. Optional features can be disabled for a local test:

```sh
BP_TEST_USE="-libpaper -zeroconf" \
  scripts/test-ebuild lib-print/cups/cups-2.4.20260818.ebuild
```

The isolated `ROOT` is intentionally not populated with host libraries.
Post-install QA can therefore report the host ELF interpreter and dependency
SONAMEs as unavailable in that root. Read the complete QA summary: reports are
diagnostic, while warnings, failures, or a non-`PASS` result must be resolved.

Run selected phases by listing them after the ebuild:

```sh
scripts/test-ebuild category/package/package-version.ebuild \
  clean unpack prepare configure
```

Useful overrides:

```sh
# Test a specific bp profile.
BP_TEST_PROFILE=core/amd64/musl \
  scripts/test-ebuild category/package/package-version.ebuild

# Keep the isolated tree for inspection.
BP_TEST_KEEP=1 \
  scripts/test-ebuild category/package/package-version.ebuild

# Reuse a persistent test tree and distfiles cache.
BP_TEST_ROOT=/tmp/bp-ebuild-test \
  scripts/test-ebuild category/package/package-version.ebuild
```

After a retained run, inspect the merged filesystem under
`$BP_TEST_ROOT/root` (or the temporary path printed by the helper). A successful
merge must include the package record under `var/db/pkg`.

When executing a binary from the retained root, point the loader at that root's
libraries so it does not silently use an installed copy of the package:

```sh
root=/tmp/bp-ebuild-test/root
"$root/usr/bin/cups-config" --version
LD_LIBRARY_PATH="$root/usr/lib" "$root/usr/bin/cupsd" -h
```

Regenerate a package Manifest through the same isolated configuration:

```sh
scripts/test-ebuild category/package/package-version.ebuild manifest
```

Before finishing an ebuild change, run at least:

```sh
scripts/test-ebuild category/package/package-version.ebuild
git diff --check
```

If dependencies are unavailable, run through `prepare`, state exactly which
dependency blocked later phases, and do not describe the package as fully
tested.
