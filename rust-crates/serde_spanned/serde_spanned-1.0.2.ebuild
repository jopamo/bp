# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_spanned"
CRATE_VERSION="1.0.2"
CRATE_CHECKSUM="5417783452c2be558477e104686f7de5dae53dba813c28435e0e70f82d9b04ee"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde-compatible spanned Value"
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"serde"
	"std"
)
