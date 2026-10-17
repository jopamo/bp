# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="archive-trait"
CRATE_VERSION="0.0.15"
CRATE_CHECKSUM="999bf88cc483664cab77700ca2fdfb0415a73412abe284ef5bc2319d00938e00"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Format-neutral, asynchronous archive construction and extraction"
HOMEPAGE="https://github.com/astral-sh/astral-codec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
