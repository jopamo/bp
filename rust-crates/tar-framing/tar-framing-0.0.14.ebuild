# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tar-framing"
CRATE_VERSION="0.0.14"
CRATE_CHECKSUM="783223a7a6590be4227cb821e7ce80372575511f67c824921aba0752d8ad5573"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A framing layer for tar archives."
HOMEPAGE="https://github.com/astral-sh/tar-codec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
