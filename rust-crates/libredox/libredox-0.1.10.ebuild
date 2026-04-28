# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libredox"
CRATE_VERSION="0.1.10"
CRATE_CHECKSUM="416f7e718bdb06000964960ffa43b4335ad4012ae8b99060261aa4a8088d5ccb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Redox stable ABI"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/libredox.git"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"call"
	"default"
	"mkns"
	"std"
)
