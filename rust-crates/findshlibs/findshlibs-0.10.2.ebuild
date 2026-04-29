# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="findshlibs"
CRATE_VERSION="0.10.2"
CRATE_CHECKSUM="40b9e59cd0f7e0806cca4be089683ecb6434e602038df21fe6bf6711b2f07f64"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Find the set of shared libraries loaded in the current process with a cross platform API"
HOMEPAGE="https://github.com/gimli-rs/findshlibs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
