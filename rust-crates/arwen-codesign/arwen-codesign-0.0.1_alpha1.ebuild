# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="arwen-codesign"
CRATE_VERSION="0.0.1-alpha.1"
CRATE_CHECKSUM="35d7a19757bfe3658d5a95bf25a0492f29ebb21933549bdbfa4075c895510124"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ad-hoc code signing for Mach-O binaries"
HOMEPAGE="https://github.com/nichmor/arwen"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
