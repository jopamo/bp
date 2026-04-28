# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml_edit"
CRATE_VERSION="0.22.23"
CRATE_CHECKSUM="02a8b472d1a3d7c18e2d61a489aee3453fd9031c33e4f55bd533f4a7adca1bee"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Yet another format-preserving TOML parser."
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"display"
	"parse"
	"perf"
	"serde"
	"unbounded"
)
