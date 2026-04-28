# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="schemars"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="a2b42f36aa1cd011945615b92222f6bf73c599a102a300334cd7f8dbeec726cc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate JSON Schemas from Rust code"
HOMEPAGE="https://graham.cool/schemars/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_ui_test"
	"default"
	"derive"
	"preserve_order"
	"raw_value"
	"std"
)
