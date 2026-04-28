# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zune-core"
CRATE_VERSION="0.4.12"
CRATE_CHECKSUM="3f423a2c17029964870cfaabb1f13dfab7d092a62a29a89264f4d36990ca414a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core utilities for image processing in the zune family of crates"
HOMEPAGE="https://github.com/etemesi254/zune-image/tree/dev/zune-core"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
