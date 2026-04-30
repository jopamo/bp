# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="object"
CRATE_VERSION="0.38.1"
CRATE_CHECKSUM="271638cd5fa9cca89c4c304675ca658efc4e64a66c716b7cfe1afb4b9611dbbc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A unified interface for reading and writing object file formats."
HOMEPAGE="https://github.com/gimli-rs/object"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all"
	"archive"
	"build"
	"build_core"
	"cargo-all"
	"coff"
	"compression"
	"default"
	"doc"
	"elf"
	"macho"
	"pe"
	"read"
	"read_core"
	"rustc-dep-of-std"
	"std"
	"unaligned"
	"unstable"
	"unstable-all"
	"wasm"
	"write"
	"write_core"
	"write_std"
	"xcoff"
)
