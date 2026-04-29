# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="object"
CRATE_VERSION="0.37.3"
CRATE_CHECKSUM="ff76201f031d8863c38aa7f905eca4f53abbfa15f609db4277d44cd8938f33fe"
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
