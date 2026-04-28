# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml_edit"
CRATE_VERSION="0.23.10+spec-1.0.0"
CRATE_CHECKSUM="84c8b9f757e028cee9fa244aea147aab2a9ec09d5325a9b01e0a49730c2b5269"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Yet another format-preserving TOML parser."
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"display"
	"parse"
	"serde"
	"unbounded"
)
