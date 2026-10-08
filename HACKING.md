# HACKING

Use `scripts/check-tree` for resolution and `scripts/test-ebuild` for package
phases. Both isolate host configuration; do not use sudo or direct host ebuilds.
The test helper does not install dependencies or populate the root with host libraries.

Ebuild changes require a full `test-ebuild` run and `git diff --check`.
If dependencies block the run, reach `prepare` and name the blocker.
