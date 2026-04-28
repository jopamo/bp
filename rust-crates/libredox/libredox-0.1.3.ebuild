# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libredox"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="c0ff37bd590ca25063e35af745c343cb7a0271906fb7b37e4813e8f79f00268d"
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
