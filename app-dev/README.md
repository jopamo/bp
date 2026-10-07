# Analyzer snapshot validation

Source-cache support and complete analyzer packaging are separate gates.
The newest Smatch and Coccinelle recipes remain masked pending the release
gates below. Their previous recipes remain available.

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

Validation uses the isolated amd64/glibc helper, GCC 15.3.1, LLVM 22.1.8,
OCaml 5.5.1 and Python 3.13. It is not an arm64 or musl build.

- Sparse builds and merges with explicit LLVM, XML, SQLite and GTK selection.
  Its suite passes: 839 passes and 65 upstream-marked expected failures.
  Installed checks exercise `sparse`, `cgcc`, `c2xml`, `semind`, `sparse-llvm`
  through `sparsec`, and generated executable behavior. The compiler wrappers
  work with both GCC and Clang. The GTK inspector opens a window under Xvfb.
  A separate GTK-disabled build passes and does not install `test-inspect`.
- OCaml builds native-code runtime archives without LTO. Its previous slim-LTO
  archive indexes omit runtime symbols after installation; reindexing a
  diagnostic copy restores native linking. The rebuilt installed toolchain
  links and runs a native program, and Findlib builds and merges.
- Coccinelle builds and merges with Python, OCaml scripting and PCRE enabled.
  Its suite passes all 765 expected-pass tests, with 21 known failures.
  Installed checks execute both scripting languages, apply a PCRE lookahead
  constraint and exercise the `pycocci` and `spgen` entry points.
- libdb, DBI, DBD-SQLite and Try-Tiny build and merge. DBD-SQLite uses the system
  SQLite library.
- Smatch's snapshot-v2 cache includes both pinned data submodules and supports
  offline unpack and compilation without retained Git object stores.
  A separate install/merge check succeeds. Installed positive/negative fixtures
  pass with LTO disabled. A minimal make fixture exercises the kernel-data and
  database pipeline without root: generated files stay in the workspace,
  SQLite integrity checking passes, and installed file hashes remain unchanged.
  This is not a full kernel analysis and does not override the failed suite.
- Sparse and Smatch locate builtin headers with the compiler's
  `-print-file-name=include` query. The previous empty-filename query can return
  a `LIBRARY_PATH` directory rather than the compiler resource directory.
- The installed images have no file-level collisions under `/usr`.
- Sparse, Smatch, Coccinelle and OCaml dependency graphs resolve for all four
  amd64/arm64 and glibc/musl profiles. Candidate masks are lifted only in the
  private resolver configurations for this check.

Run the installed checks with `scripts/test-analyzer-install`. It accepts
`--sparse-root`, `--smatch-root` and `--coccinelle-root`, defaulting to `/`.
For isolated dependency roots, supply the corresponding loader, OCaml and
Perl search paths as well. These checks supplement, rather than replace, each
upstream suite.

## Remaining release gates

- Smatch devel reports 1024 passes and 120 failures out of 1144 tests without
  LTO. Of these failures, 66 are upstream-marked expected failures and 54 are
  unexpected. Thirty tests lack the configured kernel build directory and
  three reference missing named checks. The other 21 output differences remain
  unresolved. Do not suppress these failures or claim an upstream regression
  without isolating its cause.
- The initial GCC 15 LTO Smatch build crashes in `token_store` on ordinary
  conditional expressions. Both `-O0` and `-O3` non-LTO builds avoid those
  crashes. The recipe disables LTO. The underlying LTO interaction remains
  undiagnosed.
- Smatch's `tagger` requires a preinitialized Berkeley DB environment.
  Upstream's root-level `create_tagger_db.py` uses `bsddb3`, which is absent
  from BP and the test host. Package that binding and initializer, then test
  tag creation and lookup. Installing `tagger` alone does not validate this
  workflow.
- arm64, musl, LLVM 23 and Python 3.14 execution, full kernel analysis and
  reproducible binary-package rebuilds remain unvalidated. The tested build
  environment is amd64/glibc, not the complete supported platform matrix.

Use `scripts/test-ebuild` for further builds and retain its logs. Do not
interpret successful source fetches, dependency resolution, or a separate
install check as a passing analyzer release gate.
