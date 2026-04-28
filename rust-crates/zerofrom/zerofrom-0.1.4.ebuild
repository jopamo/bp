# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerofrom"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="91ec111ce797d0e0784a1116d0ddcdbea84322cd79e5d5ad173daeba4f93ab55"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ZeroFrom trait for constructing"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"derive"
)
