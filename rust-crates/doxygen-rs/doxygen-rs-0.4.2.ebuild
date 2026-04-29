# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="doxygen-rs"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="415b6ec780d34dcf624666747194393603d0373b7141eef01d12ee58881507d9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Transform Doxygen to Rustdoc"
HOMEPAGE="https://github.com/Techie-Pi/doxygen-rs/"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
