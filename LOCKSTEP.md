# Updating `bp` with lockstep

This is the exact workflow to let `lockstep` bump packages in `bp` and create
the git commits itself.

## Preconditions

- `bp` must be a clean git worktree before `--commit` runs.
- Run the commands from the repo root: `/home/me/projects/distro`
- Use the local `lockstep` checkout, not a random installed copy.

Check cleanliness first:

```sh
git -C bp status --short --branch
```

If you previously ran a non-commit write pass and want to start over:

```sh
git -C bp reset --hard HEAD
git -C bp clean -fd
```

## 1) Preview the plan

Dry-run first:

```sh
(cd lockstep && python3 scripts/lockstep --root ../bp --resolver-mode online)
```

If you want machine-readable output:

```sh
(cd lockstep && python3 scripts/lockstep --root ../bp --resolver-mode online --format json)
```

## 2) Let lockstep write and commit

This is the command that performs the package bumps and creates one git commit
per touched package directory:

```sh
(cd lockstep && python3 scripts/lockstep --root ../bp --resolver-mode online --write --commit)
```

What `--commit` does:

- refuses to run if `bp` is dirty
- computes the update plan
- mutates package directories
- regenerates `Manifest`s
- creates git commits with messages like:
  - `foo: bumped to 1.2.3`
  - `foo: refresh managed deps`
  - `foo: add 0.9.0`
  - `foo: remove 0.8.1`

## 3) Verify the result

After a successful run:

```sh
git -C bp status --short --branch
git -C bp log --oneline -n 20
```

Expected shape:

- `bp` is clean
- branch is ahead by however many package commits lockstep created

## 4) Recovery

If you want to throw away the lockstep run completely:

```sh
git -C bp reset --hard HEAD
git -C bp clean -fd
```

If lockstep exits non-zero and you want to go back to the pre-run revision:

```sh
start_rev="$(git -C bp rev-parse HEAD)"
(cd lockstep && python3 scripts/lockstep --root ../bp --resolver-mode online --write --commit) || {
  git -C bp reset --hard "$start_rev"
  git -C bp clean -fd
  exit 1
}
```

## Notes

- `--commit` needs a clean `bp` tree. It will reject staged, unstaged, or
  untracked package-dir changes.
- In this repo, the commit author is taken from environment variables such as
  `BOT_USER` and `BOT_EMAIL` when they are set.
- Manifest regeneration may print repeated fetch warnings like
  `Couldn't download '.layout.conf.1g4.org'`. Judge success by the lockstep exit
  code and the final `mutated ...` / `committed ...` lines.
