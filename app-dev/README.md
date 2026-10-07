# Analyzer snapshot validation

Source-cache support and complete analyzer packaging are separate gates.
The newest Smatch and Coccinelle recipes remain masked while the failures below
are unresolved. Their previous recipes remain available.

## Source selection

As checked on 2026-10-07:

- Sparse master is `37156835e3d725b6d750f000be33ba3814bb2310`, already BP's pin.
  The `1g4-mirror/sparse` GitHub repository contains this commit.
- Smatch devel is `979575b829a0a4b4c3e1ca18ca38cc0d16370d90`, newer than master.
  Its kernel and Wine data repositories are pinned by the parent gitlinks.
- Coccinelle master is `25f88a5677e317e279ae10435b9adf125b0f91d1`.
  The public GitHub mirror does not resolve this commit, so the candidate uses
  Inria until the distro mirror is populated.

The other proposed `1g4-mirror` repositories returned HTTP 404. Their upstream
repositories are in the tracked `lockstep/scripts/mirror_repos` inventory.
Populate and verify those mirrors before changing the recipe URLs. No remote
repositories were created or pushed during this review.

## Completed checks

The isolated amd64/glibc helper builds and merges Sparse, libdb, DBI,
DBD-SQLite and Try-Tiny. DBD-SQLite uses the system SQLite library.

Smatch's snapshot-v2 cache includes both data submodules, contains no retained
Git object stores, and supports offline unpack and compilation. A separate
install/merge check succeeds with its private frontend and complete data/script
directories. This does not override its failed regression suite.

## Remaining release gates

- Smatch devel's upstream suite reports 805 passes and 339 failures out of 1144
  tests in the tested configuration. Failures include process crashes and
  references to missing checks. Do not suppress these failures or claim the
  candidate has passed regression testing.
- Smatch's installed `build_kernel_data.sh` still targets its adjacent data
  directory. Redirect generated data to a writable workspace and test database
  generation as an unprivileged user before releasing the package.
- Coccinelle's candidate reaches compilation with the isolated OCaml 5.5.1
  toolchain but stops with no rule to build `bundles/stdcompat/stdcompat.cmxa`.
  The isolated Findlib build also fails native linking. Resolve those failures
  before enabling and validating Python, OCaml scripting and PCRE; the current
  candidate retains the previous recipe's disabled feature switches.
- Sparse still needs explicit optional-feature selection and installed
  functionality tests. Its local build uses LLVM 22, not the requested LLVM 23.
- Installed positive/negative analysis fixtures, co-installation checks,
  reproducible rebuilds, musl and arm64 validation remain outstanding.

Use `scripts/test-ebuild` for further builds and retain its logs. Do not
interpret successful source fetches, dependency resolution, or a separate
install check as a passing analyzer release gate.
