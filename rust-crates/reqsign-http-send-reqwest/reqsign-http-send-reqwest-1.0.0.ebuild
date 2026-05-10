# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-http-send-reqwest"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="f388d66e254d67e570eba0a4a3fe39427ff7f1df26c73a8b7330e8ca1e639f80"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Signing API requests without effort."
HOMEPAGE="https://github.com/Xuanwo/reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
