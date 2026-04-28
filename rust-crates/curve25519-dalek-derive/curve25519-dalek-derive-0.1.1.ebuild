# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="curve25519-dalek-derive"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="f46882e17999c6cc590af592290432be3bce0428cb0d5f8b6715e4dc7b383eb3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="curve25519-dalek Derives"
HOMEPAGE="https://github.com/dalek-cryptography/curve25519-dalek"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
