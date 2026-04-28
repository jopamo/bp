# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo-platform"
CRATE_VERSION="0.1.9"
CRATE_CHECKSUM="e35af189006b9c0f00a064685c727031e3ed2d8020f7ba284d78cc2671bd36ea"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cargo's representation of a target platform."
HOMEPAGE="https://github.com/rust-lang/cargo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
