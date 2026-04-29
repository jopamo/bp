# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="headers-core"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="54b4a22553d4242c49fddb9ba998a99962b5cc6f22cb5a3482bec22522403ce4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="typed HTTP headers core trait"
HOMEPAGE="https://hyper.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
