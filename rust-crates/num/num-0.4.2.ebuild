# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="3135b08af27d103b0a51f2ae0f8632117b7b185ccf931445affa8df530576a41"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A collection of numeric types and traits for Rust, including bigint, complex, rational, range iterators, generic integers, and more!"
HOMEPAGE="https://github.com/rust-num/num"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"libm"
	"rand"
	"serde"
	"std"
)
