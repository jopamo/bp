# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="spki"
CRATE_VERSION="0.8.0-rc.4"
CRATE_CHECKSUM="8baeff88f34ed0691978ec34440140e1572b68c7dd4a495fd14a3dc1944daa80"
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
