# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-file-read-tokio"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="857154204885ec746f5f221393aec7dc47cbde9216b18774eb0a0c6e966f1ee0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Signing API requests without effort."
HOMEPAGE="https://github.com/Xuanwo/reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
