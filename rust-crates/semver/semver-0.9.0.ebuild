# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="semver"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="1d7eb9ef2c18661902cc47e535f9bc51b78acd254da71d375c2f6720d9a40403"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Semantic version parsing and comparison."
HOMEPAGE="https://docs.rs/crate/semver/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"ci"
	"default"
)
