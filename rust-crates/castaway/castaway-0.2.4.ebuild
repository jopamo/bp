# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="castaway"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="dec551ab6e7578819132c713a93c022a05d60159dc86e7a7050223577484c55a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safe, zero-cost downcasting for limited compile-time specialization."
HOMEPAGE="https://github.com/sagebind/castaway"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
