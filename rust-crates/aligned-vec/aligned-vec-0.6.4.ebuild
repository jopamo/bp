# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="aligned-vec"
CRATE_VERSION="0.6.4"
CRATE_CHECKSUM="dc890384c8602f339876ded803c97ad529f3842aba97f6392b3dba0dd171769b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Aligned vector and box containers"
HOMEPAGE="https://github.com/sarah-ek/aligned-vec/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"std"
)
