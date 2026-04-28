# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="as-raw-xcb-connection"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="175571dd1d178ced59193a6fc02dde1b972eb0bc56c892cde9beeceac5bf0f6b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait to facilitate interoperatibility with libxcb C API"
HOMEPAGE="https://github.com/psychon/as-raw-xcb-connection"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
)
