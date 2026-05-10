# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rancor"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="caf5f7161924b9d1cea0e4cabc97c372cea92b5f927fc13c6bca67157a0ad947"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Scalable and efficient error handling without type composition"
HOMEPAGE="https://github.com/rkyv/rancor"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
)
