# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tokio-socks"
CRATE_VERSION="0.5.3"
CRATE_CHECKSUM="a7e2948f60dbe26b35f2c7fb74ac2854c1fddded0fe9d7548fcc674a246f7615"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Asynchronous SOCKS proxy support for Rust."
HOMEPAGE="https://github.com/sticnarf/tokio-socks"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"tor"
)
