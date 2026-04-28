# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-result"
CRATE_VERSION="0.3.4"
CRATE_CHECKSUM="56f42bd332cc6c8eac5af113fc0c1fd6a8fd2aa08a0119358686e5160d0586c6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Windows error handling"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
