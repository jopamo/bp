# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="signature"
CRATE_VERSION="3.0.0-rc.10"
CRATE_CHECKSUM="7f1880df446116126965eeec169136b2e0251dba37c6223bcc819569550edea3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for cryptographic signature algorithms (e.g. ECDSA, Ed25519)"
HOMEPAGE="https://github.com/RustCrypto/traits"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"rand_core"
)
