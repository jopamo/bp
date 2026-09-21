# Profiles

`profiles.desc` lists the supported profiles for amd64 and arm64 with glibc
or musl. The base profiles are `core/<arch>/<libc>`; each also has `gui`
and `debug` variants.

The base profile's `parent` file combines these layers, in order:

1. `core` and `core/<arch>`: system packages, shared defaults, and architecture.
2. `libc/<libc>`: libc selection and toolchain policy.
3. `targets/minimal`: baseline without a graphical interface.
4. `features/default`: default compiler and linker flags.

The base profile then sets its host tuple and binary package host. Variants
inherit the base first, followed by `targets/gui` or `features/debug`.
The debug layer also inherits `features/default`. Compiler flag expressions
are evaluated in inheritance order, so feature layers recompute them after
setting their inputs.

`package.use` supplies defaults; `package.use.force` and `package.use.mask`
constrain package flags. The masks for mbedTLS and Nettle in `core/package.mask`
are intentional even though those packages are absent from this tree.

Repository-wide metadata lives alongside these layers. `categories` lists only
ebuild categories. `updates/` records package moves for installed systems;
references to old package names there are historical migration data.
