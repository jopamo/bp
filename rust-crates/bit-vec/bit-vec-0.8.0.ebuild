# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bit-vec"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="5e764a1d40d510daf35e07be9eb06e75770908c27d411ee6c92109c9840eaaf7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A vector of bits"
HOMEPAGE="https://github.com/contain-rs/bit-vec"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"borsh_std"
	"default"
	"serde_no_std"
	"serde_std"
	"std"
)
