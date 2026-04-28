# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rkyv"
CRATE_VERSION="0.7.45"
CRATE_CHECKSUM="9008cd6385b9e161d8229e1f6549dd23c3d022f132a2ea37ac3a10ac4935779b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zero-copy deserialization framework for Rust"
HOMEPAGE="https://github.com/rkyv/rkyv"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arbitrary_enum_discriminant"
	"archive_be"
	"archive_le"
	"copy"
	"copy_unsafe"
	"default"
	"size_16"
	"size_32"
	"size_64"
	"std"
	"strict"
	"uuid"
	"validation"
)
