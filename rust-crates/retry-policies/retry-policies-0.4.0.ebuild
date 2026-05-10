# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="retry-policies"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="5875471e6cab2871bc150ecb8c727db5113c9338cc3354dc5ee3425b6aa40a1c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A collection of plug-and-play retry policies for Rust projects."
HOMEPAGE="https://github.com/TrueLayer/retry-policies"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
