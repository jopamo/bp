# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="fastrand"
CRATE_VERSION="2.3.0"
CRATE_CHECKSUM="37909eebbb50d72f9059c3b6d82c0463f2ff062c9e95845c43a6c9c0355411be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple and fast random number generator"
HOMEPAGE="https://github.com/smol-rs/fastrand"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"js"
	"std"
)
