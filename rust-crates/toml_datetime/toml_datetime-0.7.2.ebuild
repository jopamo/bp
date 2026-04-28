# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml_datetime"
CRATE_VERSION="0.7.2"
CRATE_CHECKSUM="32f1085dec27c2b6632b04c80b3bb1b4300d6495d1e129693bdda7d91e72eec1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A TOML-compatible datetime type"
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
