# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="num"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="35bd024e8b2ff75562e5f34e7f4905839deb4b22955ef5e73d2fea1b9813cb23"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A collection of numeric types and traits for Rust, including bigint, complex, rational, range iterators, generic integers, and more!"
HOMEPAGE="https://github.com/rust-num/num"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"libm"
	"num-bigint"
	"rand"
	"serde"
	"std"
)
