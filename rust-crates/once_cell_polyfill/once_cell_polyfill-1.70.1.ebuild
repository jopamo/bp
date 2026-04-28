# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="once_cell_polyfill"
CRATE_VERSION="1.70.1"
CRATE_CHECKSUM="a4895175b425cb1f87721b59f0f286c2092bd4af812243672510e1ac53e2e0ad"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Polyfill for \`OnceCell\` stdlib feature for use with older MSRVs"
HOMEPAGE="https://github.com/polyfill-rs/once_cell_polyfill"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
