# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cmov"
CRATE_VERSION="0.5.4"
CRATE_CHECKSUM="0c9ea0ac24bc397ab3c98583a3c9ba74fa56b09a4449bbe172b9b1ddb016027a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Conditional move CPU intrinsics which are guaranteed on major platforms (ARM32/ARM64, x86/x86_64, RISC-V) to execute in constant-time and not be rewritten as branches by the compiler. Provides wrappers for the CMOV family of instructions on x86/x86_64 and CSEL on AArch64, along with a portable \"best-effort\" pure Rust fallback implementation."
HOMEPAGE="https://github.com/RustCrypto/utils"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
