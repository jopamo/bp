# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pkg-config"
CRATE_VERSION="0.3.34"
CRATE_CHECKSUM="f6b464fbc74e149a392436b17d523f769e057cb6877f6a5c4618bc6f11800548"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to run the pkg-config system tool at build time in order to be used in Cargo build scripts."
HOMEPAGE="https://github.com/rust-lang/pkg-config-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
