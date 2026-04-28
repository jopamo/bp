# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="is_terminal_polyfill"
CRATE_VERSION="1.70.1"
CRATE_CHECKSUM="7943c866cc5cd64cbc25b2e01621d07fa8eb2a1a23160ee81ce38704e97b8ecf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Polyfill for \`is_terminal\` stdlib feature for use with older MSRVs"
HOMEPAGE="https://github.com/polyfill-rs/is_terminal_polyfill"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
