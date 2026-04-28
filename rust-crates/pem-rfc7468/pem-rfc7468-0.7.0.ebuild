# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pem-rfc7468"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="88b39c9bfcfc231068454382784bb460aae594343fb030d46e9f50a645418412"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="PEM Encoding (RFC 7468) for PKIX, PKCS, and CMS Structures, implementing a strict subset of the original Privacy-Enhanced Mail encoding intended specifically for use with cryptographic keys, certificates, and other messages. Provides a no_std-friendly, constant-time implementation suitable for use with cryptographic private keys."
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/pem-rfc7468"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"std"
)
