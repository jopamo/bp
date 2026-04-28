# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml_datetime"
CRATE_VERSION="0.7.3"
CRATE_CHECKSUM="f2cdb639ebbc97961c51720f858597f7f24c4fc295327923af55b74c3c724533"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A TOML-compatible datetime type"
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"serde"
	"std"
)
