# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cfg-if"
CRATE_VERSION="1.0.4"
CRATE_CHECKSUM="9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro to ergonomically define an item depending on a large number of #[cfg] parameters. Structured like an if-else chain, the first matching branch is the item that gets emitted."
HOMEPAGE="https://github.com/rust-lang/cfg-if"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"rustc-dep-of-std"
)
