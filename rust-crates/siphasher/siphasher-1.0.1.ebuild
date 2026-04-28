# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="siphasher"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="56199f7ddabf13fe5074ce809e7d3f42b42ae711800501b5b16ea82ad029c39d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SipHash-2-4, SipHash-1-3 and 128-bit variants in pure Rust"
HOMEPAGE="https://docs.rs/siphasher"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde_no_std"
	"serde_std"
	"std"
)
