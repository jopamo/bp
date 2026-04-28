# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="approx"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="cab112f0a86d568ea0e627cc1d6be74a1e9cd55214684db5561995f6dad897c6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Approximate floating point equality comparisons and assertions."
HOMEPAGE="https://github.com/brendanzab/approx"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
