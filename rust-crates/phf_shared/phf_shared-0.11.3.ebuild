# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="phf_shared"
CRATE_VERSION="0.11.3"
CRATE_CHECKSUM="67eabc2ef2a60eb7faa00097bd1ffdb5bd28e62bf39990626a582201b7a754e5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Support code shared by PHF libraries"
HOMEPAGE="https://github.com/rust-phf/rust-phf"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
