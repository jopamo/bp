# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="percent-encoding"
CRATE_VERSION="2.3.2"
CRATE_CHECKSUM="9b4f627cb1b25917193a259e49bdad08f671f8d9708acfd5fe0a8c1455d87220"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Percent encoding and decoding"
HOMEPAGE="https://github.com/servo/rust-url/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
