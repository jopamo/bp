# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libredox"
CRATE_VERSION="0.1.14"
CRATE_CHECKSUM="1744e39d1d6a9948f4f388969627434e31128196de472883b39f148769bfe30a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Redox stable ABI"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/libredox.git"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"base"
	"call"
	"default"
	"mkns"
	"protocol"
	"std"
)
