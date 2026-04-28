# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dlib"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="330c60081dcc4c72131f8eb70510f1ac07223e5d4163db481a04a0befcffa412"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper macros for handling manually loading optional system libraries."
HOMEPAGE="https://github.com/elinorbgr/dlib"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
