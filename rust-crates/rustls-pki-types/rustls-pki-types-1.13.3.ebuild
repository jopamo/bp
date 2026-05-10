# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustls-pki-types"
CRATE_VERSION="1.13.3"
CRATE_CHECKSUM="4910321ebe4151be888e35fe062169554e74aad01beafed60410131420ceffbc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared types for the rustls PKI ecosystem"
HOMEPAGE="https://github.com/rustls/pki-types"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
	"web"
)
