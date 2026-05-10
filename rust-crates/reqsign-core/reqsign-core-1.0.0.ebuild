# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-core"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="35fd7359352a79b293168785b9cbb239e7017b4fa0c934351518feee394f92bc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Signing API requests without effort."
HOMEPAGE="https://github.com/Xuanwo/reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
