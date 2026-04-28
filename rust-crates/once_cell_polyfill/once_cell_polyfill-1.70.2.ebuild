# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="once_cell_polyfill"
CRATE_VERSION="1.70.2"
CRATE_CHECKSUM="384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
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
