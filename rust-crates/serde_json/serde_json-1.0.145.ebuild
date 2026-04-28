# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_json"
CRATE_VERSION="1.0.145"
CRATE_CHECKSUM="402a6f66d8c709116cf22f558eab210f5a50187f702eb4d7e5ef38d9a7f1c79c"
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
