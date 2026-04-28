# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_json"
CRATE_VERSION="1.0.149"
CRATE_CHECKSUM="83fc039473c5595ace860d8c4fafa220ff474b3fc6bfdb4293327f1a37e94d86"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A JSON serialization file format"
HOMEPAGE="https://github.com/serde-rs/json"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
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
