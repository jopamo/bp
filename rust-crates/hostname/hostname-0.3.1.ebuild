# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hostname"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="3c731c3e10504cc8ed35cfe2f1db4c9274c3d35fa486e3b31df46f068ef3e867"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform system's host name functions"
HOMEPAGE="https://github.com/svartalf/hostname"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"set"
)
