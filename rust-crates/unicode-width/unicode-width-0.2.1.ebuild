# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-width"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="4a1a07cc7db3810833284e8d372ccdc6da29741639ecc70c9ec107df0fa6154c"
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
