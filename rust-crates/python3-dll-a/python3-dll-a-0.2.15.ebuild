# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="python3-dll-a"
CRATE_VERSION="0.2.15"
CRATE_CHECKSUM="d80ba7540edb18890d444c5aa8e1f1f99b1bdf26fb26ae383135325f4a36042b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Standalone python3(y)(t).dll import library generator"
HOMEPAGE="https://github.com/PyO3/python3-dll-a"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
