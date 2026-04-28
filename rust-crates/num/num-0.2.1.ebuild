# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="b8536030f9fea7127f841b45bb6243b27255787fb4eb83958aa1ef9d2fdc0c36"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A collection of numeric types and traits for Rust, including bigint, complex, rational, range iterators, generic integers, and more!"
HOMEPAGE="https://github.com/rust-num/num"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"i128"
	"rand"
	"serde"
	"std"
)
