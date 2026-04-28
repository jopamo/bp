# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libdbus-sys"
CRATE_VERSION="0.2.5"
CRATE_CHECKSUM="06085512b750d640299b79be4bad3d2fa90a9c00b1fd9e1b46364f66f0485c72"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI bindings to libdbus."
HOMEPAGE="https://github.com/diwic/dbus-rs"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"vendored"
)
