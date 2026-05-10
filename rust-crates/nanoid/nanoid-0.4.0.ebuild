# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="nanoid"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="3ffa00dec017b5b1a8b7cf5e2c008bfda1aa7e0697ac1508b491fdf2622fb4d8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tiny, secure, URL-friendly, unique string ID generator for Rust."
HOMEPAGE="https://github.com/nikolay-govorov/nanoid"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
