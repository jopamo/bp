# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="is_terminal_polyfill"
CRATE_VERSION="1.70.2"
CRATE_CHECKSUM="a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Polyfill for `is_terminal` stdlib feature for use with older MSRVs"
HOMEPAGE="https://github.com/polyfill-rs/is_terminal_polyfill"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
