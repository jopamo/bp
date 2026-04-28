# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ron"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="b91f7eff05f748767f183df4320a63d6936e9c6107d97c9e6bdd9784f4289c94"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rusty Object Notation"
HOMEPAGE="https://github.com/ron-rs/ron"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"integer128"
)
