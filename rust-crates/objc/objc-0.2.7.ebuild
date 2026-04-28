# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="objc"
CRATE_VERSION="0.2.7"
CRATE_CHECKSUM="915b1b472bc21c53464d6c8461c9d3af805ba1ef837e1cac254428f4a77177b1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Objective-C Runtime bindings and wrapper for Rust."
HOMEPAGE="http://github.com/SSheldon/rust-objc"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"exception"
	"verify_message"
)
