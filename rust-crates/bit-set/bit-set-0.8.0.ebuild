# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bit-set"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="08807e080ed7f9d5433fa9b275196cfc35414f66a0c79d864dc51a0d825231a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A set of bits"
HOMEPAGE="https://github.com/contain-rs/bit-set"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"std"
)
