# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="der"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="71fd89660b2dc699704064e59e9dba0147b903e85319429e131620d022be411b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust embedded-friendly implementation of the Distinguished Encoding Rules (DER) for Abstract Syntax Notation One (ASN.1) as described in ITU X.690 with full support for heapless \`no_std\`/\`no_alloc\` targets"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/der"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arbitrary"
	"ber"
	"bytes"
	"derive"
	"oid"
	"pem"
	"real"
	"std"
)
