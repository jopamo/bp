# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="sha2-asm"
CRATE_VERSION="0.6.4"
CRATE_CHECKSUM="b845214d6175804686b2bd482bcffe96651bb2d1200742b712003504a2dac1ab"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Assembly implementation of SHA-2 compression functions"
HOMEPAGE="https://github.com/RustCrypto/asm-hashes"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
