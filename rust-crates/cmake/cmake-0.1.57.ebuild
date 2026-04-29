# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="cmake"
CRATE_VERSION="0.1.57"
CRATE_CHECKSUM="75443c44cd6b379beb8c5b45d85d0773baf31cce901fe7bb252f4eff3008ef7d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A build dependency for running \`cmake\` to build a native library"
HOMEPAGE="https://github.com/rust-lang/cmake-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
