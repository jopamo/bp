# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerocopy-derive"
CRATE_VERSION="0.8.27"
CRATE_CHECKSUM="88d2b8d9c68ad2b9e4340d7832716a4d21a22a1154777ad56ea55c51a9cf3831"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for traits from the zerocopy crate"
HOMEPAGE="https://github.com/google/zerocopy"
LICENSE="|| ( BSD-2-Clause Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
