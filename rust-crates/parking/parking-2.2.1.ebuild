# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="parking"
CRATE_VERSION="2.2.1"
CRATE_CHECKSUM="f38d5652c16fde515bb1ecef450ab0f6a219d619a7274976324d5e377f7dceba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Thread parking and unparking"
HOMEPAGE="https://github.com/smol-rs/parking"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
