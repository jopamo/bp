# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml"
CRATE_VERSION="0.8.23"
CRATE_CHECKSUM="dc1beb996b9d83529a9e75c17a1686767d148d70663143c7854d8b4a09ced362"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A native Rust encoder and decoder of TOML-formatted files and streams. Provides implementations of the standard Serialize/Deserialize traits for TOML data to facilitate deserializing and serializing Rust structures."
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"display"
	"parse"
	"preserve_order"
	"unbounded"
)
