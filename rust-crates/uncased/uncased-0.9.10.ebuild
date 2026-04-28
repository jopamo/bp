# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="uncased"
CRATE_VERSION="0.9.10"
CRATE_CHECKSUM="e1b88fcfe09e89d3866a5c11019378088af2d24c3fbd4f0543f96b479ec90697"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Case-preserving, ASCII case-insensitive, no_std string types."
HOMEPAGE="https://github.com/SergioBenitez/uncased"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"with-serde"
	"with-serde-alloc"
)
