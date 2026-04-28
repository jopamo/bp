# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="spki"
CRATE_VERSION="0.7.3"
CRATE_CHECKSUM="d91ed6c858b01f942cd56b37a94b3e0a1798290327d1236e4d9cf4eaca44d29d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="X.509 Subject Public Key Info (RFC5280) describing public keys as well as their associated AlgorithmIdentifiers (i.e. OIDs)"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/spki"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arbitrary"
	"base64"
	"fingerprint"
	"pem"
	"std"
)
