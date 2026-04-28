# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml"
CRATE_VERSION="0.5.11"
CRATE_CHECKSUM="f4f7f0dd8d50a853a531c426359045b1998f04219d88799810762cd4ad314234"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A native Rust encoder and decoder of TOML-formatted files and streams. Provides implementations of the standard Serialize/Deserialize traits for TOML data to facilitate deserializing and serializing Rust structures."
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"preserve_order"
)
