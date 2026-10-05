# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="lax-core"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="31e9266de41ab34dbeb7b0176a6430b1091f1fa7f4dd9f7ccf3e430a9c5a6789"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared printing machinery for the lax formatter family (lax-css, lax-sql, lax-markup)."
HOMEPAGE="https://github.com/bartlomieju/lax"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
