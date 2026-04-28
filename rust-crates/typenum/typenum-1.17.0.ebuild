# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="typenum"
CRATE_VERSION="1.17.0"
CRATE_CHECKSUM="42ff0bf0c66b8238c6f3b578df37d0b7848e55df8577b3f74f92a69acceeb825"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Typenum is a Rust library for type-level numbers evaluated at compile time. It currently supports bits, unsigned integers, and signed integers. It also provides a type-level array of type-level numbers, but its implementation is incomplete."
HOMEPAGE="https://github.com/paholg/typenum"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const-generics"
	"force_unix_path_separator"
	"i128"
	"no_std"
	"scale_info"
	"strict"
)
