# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="python-pkginfo"
CRATE_VERSION="0.6.8"
CRATE_CHECKSUM="229fe47647d6602b9b0934b21fab8aece1c5a5aeb0a934196a14355fec656623"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parse Python package metadata from sdist and bdists and etc."
HOMEPAGE="https://github.com/PyO3/python-pkginfo-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"deprecated-formats"
)
