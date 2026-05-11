# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pem-rfc7468"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="a6305423e0e7738146434843d1694d621cce767262b2a86910beab705e4493d9"
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
