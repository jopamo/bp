# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="gimli"
CRATE_VERSION="0.32.3"
CRATE_CHECKSUM="e629b9b98ef3dd8afe6ca2bd0f89306cec16d43d907889945bc5d6687f2f13c7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for reading and writing the DWARF debugging format."
HOMEPAGE="https://github.com/gimli-rs/gimli"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"endian-reader"
	"fallible-iterator"
	"read"
	"read-all"
	"read-core"
	"rustc-dep-of-std"
	"std"
	"write"
)
