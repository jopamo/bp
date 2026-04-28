# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="diff"
CRATE_VERSION="0.1.13"
CRATE_CHECKSUM="56254986775e3233ffa9c4d7d3faaf6d36a2c09d30b20687e9f88bc8bafc16c8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An LCS based slice and string diffing implementation."
HOMEPAGE="https://github.com/utkarshkukreti/diff.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
