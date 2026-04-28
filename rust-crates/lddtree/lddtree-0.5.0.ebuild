# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lddtree"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="39f71c5bd42adf4ee8e6b24da58c1f00a2817d27f618b169399f5adbf9e74492"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Read the ELF dependency tree"
HOMEPAGE="https://github.com/messense/lddtree-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
