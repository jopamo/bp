# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jod-thread"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="a037eddb7d28de1d0fc42411f501b53b75838d313908078d6698d064f3029b24"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="std::thread which joins on drop by default."
HOMEPAGE="https://github.com/matklad/jod-thread"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
