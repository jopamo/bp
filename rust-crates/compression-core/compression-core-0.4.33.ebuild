# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="compression-core"
CRATE_VERSION="0.4.33"
CRATE_CHECKSUM="6e8ccc4ea9f6acc32d102c0f6d471d11d913ad15f20c04de743374861fa1d414"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Abstractions for compression algorithms."
HOMEPAGE="https://github.com/Nullus157/async-compression"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
