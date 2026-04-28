# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dwrote"
CRATE_VERSION="0.11.5"
CRATE_CHECKSUM="9e1b35532432acc8b19ceed096e35dfa088d3ea037fe4f3c085f1f97f33b4d02"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lightweight binding to DirectWrite."
HOMEPAGE="https://github.com/servo/dwrote-rs"
LICENSE="MPL-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde_serialization"
)
