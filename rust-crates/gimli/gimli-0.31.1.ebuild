# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="gimli"
CRATE_VERSION="0.31.1"
CRATE_CHECKSUM="07e28edb80900c19c28f1072f2e8aeca7fa06b23cd4169cefe1af5aa3260783f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for reading and writing the DWARF debugging format."
HOMEPAGE="https://github.com/gimli-rs/gimli"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
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
