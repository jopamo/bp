# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cfb"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="d8a4f8e55be323b378facfcf1f06aa97f6ec17cf4ac84fb17325093aaf62da41"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Read/write Compound File Binary (structured storage) files"
HOMEPAGE="https://github.com/mdsteele/rust-cfb"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
