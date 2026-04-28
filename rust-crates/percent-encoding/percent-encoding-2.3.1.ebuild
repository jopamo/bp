# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="percent-encoding"
CRATE_VERSION="2.3.1"
CRATE_CHECKSUM="e3148f5046208a5d56bcfc03053e3ca6334e51da8dfb19b6cdc8b306fae3283e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Percent encoding and decoding"
HOMEPAGE="https://github.com/servo/rust-url/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
