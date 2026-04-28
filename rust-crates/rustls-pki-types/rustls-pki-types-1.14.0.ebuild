# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls-pki-types"
CRATE_VERSION="1.14.0"
CRATE_CHECKSUM="be040f8b0a225e40375822a563fa9524378b9d63112f53e19ffff34df5d33fdd"
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
