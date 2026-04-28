# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="inout"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="a0c10553d664a4d0bcff9f4215d0aac67a639cc68ef660840afe309b807bc9f5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom reference types for code generic over in-place and buffer-to-buffer modes of operation."
HOMEPAGE="https://github.com/RustCrypto/utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
