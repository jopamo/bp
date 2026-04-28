# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="orbclient"
CRATE_VERSION="0.3.48"
CRATE_CHECKSUM="ba0b26cec2e24f08ed8bb31519a9333140a6599b867dac464bb150bdb796fd43"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The Orbital Client Library"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/orbclient"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bundled"
	"default"
	"sdl"
	"std"
	"unifont"
)
