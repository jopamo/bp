# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="schemars"
CRATE_VERSION="1.0.4"
CRATE_CHECKSUM="82d20c4491bc164fa2f6c5d44565947a52ad80b9505d8e36f8d54c27c739fcd0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate JSON Schemas from Rust code"
HOMEPAGE="https://graham.cool/schemars/"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"_ui_test"
	"default"
	"derive"
	"preserve_order"
	"raw_value"
	"std"
)
