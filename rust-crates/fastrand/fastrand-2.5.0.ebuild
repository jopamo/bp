# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fastrand"
CRATE_VERSION="2.5.0"
CRATE_CHECKSUM="da7c62ceae207dd37ea5b845da6a0696c799f85e97da1ab5b7910be3c1c80223"
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
