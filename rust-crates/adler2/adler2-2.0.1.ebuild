# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="adler2"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="320119579fcad9c21884f5c4861d16174d0e06250625266f50fe6898340abefa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple clean-room implementation of the Adler-32 checksum"
HOMEPAGE="https://github.com/oyvindln/adler2"
LICENSE="|| ( 0BSD MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
	"std"
)
