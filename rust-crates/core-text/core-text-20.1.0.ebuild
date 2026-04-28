# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="core-text"
CRATE_VERSION="20.1.0"
CRATE_CHECKSUM="c9d2790b5c08465d49f8dc05c8bcae9fea467855947db39b0f8145c091aaced5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to the Core Text framework."
HOMEPAGE="https://github.com/servo/core-foundation-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"mountainlion"
)
