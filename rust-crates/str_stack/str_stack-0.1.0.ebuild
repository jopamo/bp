# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="str_stack"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="9091b6114800a5f2141aee1d1b9d6ca3592ac062dc5decb3764ec5895a47b4eb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A string allocator for allocating many write-once strings. This library is primarily useful for parsing where you need to repeatedly build many strings, use them, and then throw them away. Instead of allocating many independent strings, this library will put them all in the same buffer."
HOMEPAGE="https://github.com/Stebalien/str_stack"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
