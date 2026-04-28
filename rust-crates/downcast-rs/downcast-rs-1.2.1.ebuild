# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="downcast-rs"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="75b325c5dbd37f80359721ad39aca5a29fb04c89279657cffdda8736d0c0b9d2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait object downcasting support using only safe Rust. It supports type parameters, associated types, and type constraints."
HOMEPAGE="https://github.com/marcianx/downcast-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
