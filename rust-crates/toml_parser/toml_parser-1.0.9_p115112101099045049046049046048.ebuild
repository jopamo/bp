# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="toml_parser"
CRATE_VERSION="1.0.9+spec-1.1.0"
CRATE_CHECKSUM="702d4415e08923e7e1ef96cd5727c0dfed80b4d2fa25db9647fe5eb6f7c5a4c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Yet another format-preserving TOML parser."
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"debug"
	"default"
	"simd"
	"std"
	"unsafe"
)
