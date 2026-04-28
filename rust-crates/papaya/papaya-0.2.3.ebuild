# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="papaya"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="f92dd0b07c53a0a0c764db2ace8c541dc47320dad97c2200c2a637ab9dd2328f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast and ergonomic concurrent hash-table for read-heavy workloads."
HOMEPAGE="https://github.com/ibraheemdev/papaya"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
)
