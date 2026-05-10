# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="schannel"
CRATE_VERSION="0.1.27"
CRATE_CHECKSUM="1f29ebaa345f945cec9fbbc532eb307f0fdad8161f281b6369539c8d84876b3d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Schannel bindings for rust, allowing SSL/TLS (e.g. https) without openssl"
HOMEPAGE="https://github.com/steffengy/schannel-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
