# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rfc6979"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="f8dd2a808d456c4a54e300a23e9f5a67e122c3024119acbfd73e3bf664491cb2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of RFC6979: Deterministic Usage of the Digital Signature Algorithm (DSA) and Elliptic Curve Digital Signature Algorithm (ECDSA)"
HOMEPAGE="https://github.com/RustCrypto/signatures/tree/master/rfc6979"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
