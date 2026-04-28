# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="denokv_proto"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="645cfd5bdec33d2e5c4188ea2a7b348eca13958afa4c76a11504d9aa0efca589"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fundamental types, traits, and protobuf models for denokv"
HOMEPAGE="https://github.com/denoland/denokv"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"build_protos"
)
