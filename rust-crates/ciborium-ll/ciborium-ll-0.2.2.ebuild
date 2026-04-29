# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ciborium-ll"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="57663b653d948a338bfb3eeba9bb2fd5fcfaecb9e199e87e1eda4d9e8b240fd9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low-level CBOR codec primitives"
HOMEPAGE="https://github.com/enarx/ciborium"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"std"
)
