# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="der"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="6a996a108feb8b427a6e12fcf6af4aa83409b79d72c15337d7741368131ee004"
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
