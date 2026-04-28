# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dbus"
CRATE_VERSION="0.9.7"
CRATE_CHECKSUM="1bb21987b9fb1613058ba3843121dd18b163b254d8a6e797e144cbac14d96d1b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to D-Bus, which is a bus commonly used on Linux for inter-process communication."
HOMEPAGE="https://github.com/diwic/dbus-rs"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"futures"
	"no-string-validation"
	"stdfd"
	"vendored"
)
