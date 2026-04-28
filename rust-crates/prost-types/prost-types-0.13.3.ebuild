# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="prost-types"
CRATE_VERSION="0.13.3"
CRATE_CHECKSUM="4759aa0d3a6232fb8dbdb97b61de2c20047c68aca932c7ed76da9d788508d670"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Prost definitions of Protocol Buffers well known types."
HOMEPAGE="https://github.com/tokio-rs/prost"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
