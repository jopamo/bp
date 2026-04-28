# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="object"
CRATE_VERSION="0.36.3"
CRATE_CHECKSUM="27b64972346851a39438c60b341ebc01bba47464ae329e55cf343eb93964efd9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A unified interface for reading and writing object file formats."
HOMEPAGE="https://github.com/gimli-rs/object"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
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
