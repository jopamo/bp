# Repository Guidelines

## Project Structure & Module Organization
- Category directories (`app-*`, `lib-*`, `xgui-*`, `xmedia-*`, `virtual/`, `core-perl/`, `dev-*`) each contain package directories with versioned `*.ebuild` files and any `files/` patches.
- `eclass/` holds shared eclasses; update documentation when adding or modifying one.
- `profiles/` tracks repo metadata (profiles, package.mask/use.mask, arches, license groups); keep `repo_name` and `layout.conf` aligned with changes.
- `licenses/` and `distfiles/` mirror upstream licensing and fetched sources; avoid committing large tarballs unless required.
- `metadata/` caches may exist; regenerate via standard tools instead of editing by hand.

## Build, Test, and Development Commands
- Regenerate manifests after any SRC_URI change:
  ```sh
  pkgdev manifest category/package
  # or: ebuild category/package/foo-1.0.ebuild manifest
  ```
- Lint overlay consistency:
  ```sh
  pkgcheck scan
  ```
- Run package tests when available:
  ```sh
  FEATURES=test ebuild category/package/foo-1.0.ebuild test
  ```
- Local install verification (use a disposable root if needed):
  ```sh
  emerge --ask --oneshot category/package
  ```
- For broader QA on a set of changes, run `pkgdev ci` (or `repoman full` if legacy tooling is preferred).

## Coding Style & Naming Conventions
- Ebuilds use the current supported EAPI unless upstream constraints dictate otherwise.
- Tabs for indentation; keep logical blocks under ~100 columns.
- Order top-level keys conventionally: `EAPI`, `DESCRIPTION`, `HOMEPAGE`, `SRC_URI`, `LICENSE`, `SLOT`, `KEYWORDS`, `IUSE`, `DEPEND`, `RDEPEND`, `BDEPEND`, then phase functions.
- Package directories follow `category/name/name-version.ebuild`; live ebuilds use `-9999` with `EGIT_REPO_URI`/`VCS_ECLASS`.
- Prefer `https` SRC_URI, verified checksums, and upstream tarballs over vendored blobs.

## Testing Guidelines
- Require a clean `pkgcheck scan` before submitting.
- If tests exist, run `FEATURES=test` and note pass/fail; skip only with justification in the commit message.
- When adding patches, explain their purpose in a comment near `src_prepare` and keep them minimal.
- For arch keyword changes, verify build on each keyworded arch or mark unstable (`~arch`) accordingly.

## Commit & Pull Request Guidelines
- Commit messages: `category/package: imperative summary` (72-char subject), include `Signed-off-by: Name <email>` if contributing upstream or mirroring Gentoo practice.
- Each PR should describe the change, reference upstream issues/bugs, list test commands run, and include impact notes (new deps, USE defaults, slot changes).
- Keep unrelated bumps separate; one logical change per commit helps review and git history.
