# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="self-replace"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="03ec815b5eab420ab893f63393878d89c90fdd94c0bcc44c07abb8ad95552fb7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utility crate that allows executables to replace or uninstall themselves"
HOMEPAGE="https://github.com/mitsuhiko/self-replace"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
