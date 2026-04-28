# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="core-graphics"
CRATE_VERSION="0.23.2"
CRATE_CHECKSUM="c07782be35f9e1140080c6b96f0d44b739e2278479f64e02fdab4e32dfd8b081"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to Core Graphics for macOS"
HOMEPAGE="https://github.com/servo/core-foundation-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"elcapitan"
	"highsierra"
	"link"
)
