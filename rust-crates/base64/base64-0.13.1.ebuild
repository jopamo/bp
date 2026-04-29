# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="base64"
CRATE_VERSION="0.13.1"
CRATE_CHECKSUM="9e1b586273c5702936fe7b7d6896644d8be71e6314cfe09d3167c95f712589e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="encodes and decodes base64 as bytes or utf8"
HOMEPAGE="https://github.com/marshallpierce/rust-base64"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
