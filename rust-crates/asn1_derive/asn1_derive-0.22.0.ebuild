# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="asn1_derive"
CRATE_VERSION="0.22.0"
CRATE_CHECKSUM="cdccf849b54365e3693e9a90ad36e4482b79937e6373ac8e2cf229c985187b21"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="#[derive] support for asn1"
HOMEPAGE="https://github.com/alex/rust-asn1"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
