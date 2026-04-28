# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml_writer"
CRATE_VERSION="1.0.3"
CRATE_CHECKSUM="d163a63c116ce562a22cda521fcc4d79152e7aba014456fb5eb442f6d6a10109"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A low-level interface for writing out TOML"
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
