# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml_edit"
CRATE_VERSION="0.22.27"
CRATE_CHECKSUM="41fe8c660ae4257887cf66394862d21dbca4a6ddd26f04a3560410406a2f819a"
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
	"unstable-debug"
)
