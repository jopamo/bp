# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml_edit"
CRATE_VERSION="0.24.0+spec-1.1.0"
CRATE_CHECKSUM="8c740b185920170a6d9191122cafef7010bd6270a3824594bff6784c04d7f09e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Yet another format-preserving TOML parser."
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"display"
	"parse"
	"serde"
	"unbounded"
)
