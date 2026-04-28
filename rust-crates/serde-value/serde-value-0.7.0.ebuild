# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde-value"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="f3a1a3341211875ef120e117ea7fd5228530ae7e7036a779fdc9117be6b3282c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serialization value trees"
HOMEPAGE="https://github.com/arcnmx/serde-value"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
