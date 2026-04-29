# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="asn1_derive"
CRATE_VERSION="0.24.1"
CRATE_CHECKSUM="909e307f1cc32bb8bccbd98f446e6d1bf03fa30f7b53a4337da7181ad30fa11a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="#[derive] support for asn1"
HOMEPAGE="https://github.com/alex/rust-asn1"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
