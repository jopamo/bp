# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jni-sys-macros"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="38c0b942f458fe50cdac086d2f946512305e5631e720728f2a61aabcd47a6264"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for jni-sys crate"
HOMEPAGE="https://github.com/jni-rs/jni-sys"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
