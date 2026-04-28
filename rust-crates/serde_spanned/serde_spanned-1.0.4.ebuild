# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_spanned"
CRATE_VERSION="1.0.4"
CRATE_CHECKSUM="f8bbf91e5a4d6315eee45e704372590b30e260ee83af6639d64557f51b067776"
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
