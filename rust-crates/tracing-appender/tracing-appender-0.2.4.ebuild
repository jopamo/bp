# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tracing-appender"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="786d480bce6247ab75f005b14ae1624ad978d3029d9113f0a22fa1ac773faeaf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides utilities for file appenders and making non-blocking writers."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
