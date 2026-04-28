# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rawpointer"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="60a357793950651c4ed0f3f52338f53b2f809f32d83a07f72909fa13e4c6c1e3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Extra methods for raw pointers and \`NonNull<T>\`. For example \`.post_inc()\` and \`.pre_dec()\` (c.f. \`ptr++\` and \`--ptr\`), \`offset\` and \`add\` for \`NonNull<T>\`, and the function \`ptrdistance\`."
HOMEPAGE="https://github.com/bluss/rawpointer/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
