# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="triomphe"
CRATE_VERSION="0.1.14"
CRATE_CHECKSUM="ef8f7726da4807b58ea5c96fdc122f80702030edc33b35aff9190a51148ccc85"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fork of std::sync::Arc with some extra functionality and without weak references (originally servo_arc)"
HOMEPAGE="https://github.com/Manishearth/triomphe"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
