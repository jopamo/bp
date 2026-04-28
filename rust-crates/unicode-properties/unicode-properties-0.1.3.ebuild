# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-properties"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="e70f2a8b45122e719eb623c01822704c4e0907e7e426a05927e1a1cfff5b75d0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Query character Unicode properties according to UAX #44 and UTR #51."
HOMEPAGE="https://github.com/unicode-rs/unicode-properties"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"emoji"
	"general-category"
)
