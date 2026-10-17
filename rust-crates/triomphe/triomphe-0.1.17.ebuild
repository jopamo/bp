# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="triomphe"
CRATE_VERSION="0.1.17"
CRATE_CHECKSUM="0d15f4f5898bcfc5d8a8e45ed30b2f108d710c1a2e5489dbf80e078f707181bc"
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
	"unstable_dropck_eyepatch"
)
