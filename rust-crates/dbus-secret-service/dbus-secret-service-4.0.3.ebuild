# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dbus-secret-service"
CRATE_VERSION="4.0.3"
CRATE_CHECKSUM="b42a16374481d92aed73ae45b1f120207d8e71d24fb89f357fadbd8f946fd84b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library to interface with Secret Service API over DBUS"
HOMEPAGE="https://github.com/brotskydotcom/dbus-secret-service"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"crypto-openssl"
	"crypto-rust"
	"vendored"
)
