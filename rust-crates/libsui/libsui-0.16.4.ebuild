# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libsui"
CRATE_VERSION="0.16.4"
CRATE_CHECKSUM="3cd44dd0a322ec9fb05619e59067d1c767718238677369d9c5f004ea26a1184b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A injection tool for executable formats (ELF, PE, Mach-O) that allows you to embed files into existing binary and extract them at runtime"
HOMEPAGE="https://github.com/denoland/sui"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
