# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="combine"
CRATE_VERSION="4.6.7"
CRATE_CHECKSUM="ba5a308b75df32fe02788e748662718f03fde005016435c444eea572398219fd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast parser combinators on arbitrary streams with zero-copy support."
HOMEPAGE="https://github.com/Marwes/combine"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"futures-03"
	"mp4"
	"pin-project"
	"std"
	"tokio"
	"tokio-02"
	"tokio-03"
)
