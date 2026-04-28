# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls-pki-types"
CRATE_VERSION="1.12.0"
CRATE_CHECKSUM="229a4a4c221013e7e1f1a043678c5cc39fe5171437c88fb47151a21e6f5b5c79"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared types for the rustls PKI ecosystem"
HOMEPAGE="https://github.com/rustls/pki-types"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
	"web"
)
