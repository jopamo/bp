# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="der"
CRATE_VERSION="0.7.9"
CRATE_CHECKSUM="f55bf8e7b65898637379c1b74eb1551107c8294ed26d855ceb9fd1a09cfc9bc0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust embedded-friendly implementation of the Distinguished Encoding Rules (DER) for Abstract Syntax Notation One (ASN.1) as described in ITU X.690 with full support for heapless no_std targets"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/der"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arbitrary"
	"bytes"
	"derive"
	"oid"
	"pem"
	"real"
	"std"
)
