# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="archive-trait"
CRATE_VERSION="0.0.14"
CRATE_CHECKSUM="c6080ea14ccf9019d7ce572c319e581c20a805c9bdc6dbfb9b988da003cbd1a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Format-neutral, asynchronous archive construction and extraction"
HOMEPAGE="https://github.com/astral-sh/tar-codec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
