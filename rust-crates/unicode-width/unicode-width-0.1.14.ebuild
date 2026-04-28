# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-width"
CRATE_VERSION="0.1.14"
CRATE_CHECKSUM="7dd6e30e90baa6f72411720665d41d89b9a3d039dc45b8faea1ddd07f617f6af"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine displayed width of \`char\` and \`str\` types according to Unicode Standard Annex #11 rules."
HOMEPAGE="https://github.com/unicode-rs/unicode-width"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cjk"
	"default"
	"no_std"
	"rustc-dep-of-std"
)
