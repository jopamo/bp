# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="arwen"
CRATE_VERSION="0.0.5"
CRATE_CHECKSUM="d44cbd9bd79165abe331ebabb9dd4d59a5dc93791be33ff15ebd71baaadc85ba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A cross-platform binary patching tool for Mach-O and ELF."
HOMEPAGE="https://github.com/nichmor/arwen"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
