# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_json"
CRATE_VERSION="1.0.140"
CRATE_CHECKSUM="20068b6e96dc6c9bd23e01df8827e6c7e1f2fddd43c21810382803c136b99373"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A JSON serialization file format"
HOMEPAGE="https://github.com/serde-rs/json"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arbitrary_precision"
	"default"
	"float_roundtrip"
	"preserve_order"
	"raw_value"
	"std"
	"unbounded_depth"
)
