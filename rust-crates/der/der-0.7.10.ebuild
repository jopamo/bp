# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="der"
CRATE_VERSION="0.7.10"
CRATE_CHECKSUM="e7c1832837b905bbfb5101e07cc24c8deddf52f93225eee6ead5f4d63d53ddcb"
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
