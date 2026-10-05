# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cpubits"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="5ef0c543070d296ea414df2dd7625d1b24866ce206709d8a4a424f28377f5861"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Compile-time detection heuristics for the optimal word size to use for the target CPU, which in some cases may differ from its address size a.k.a. \`target_pointer_width\`. Implemented as \`macro_rules!\`"
HOMEPAGE="https://github.com/RustCrypto/utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
