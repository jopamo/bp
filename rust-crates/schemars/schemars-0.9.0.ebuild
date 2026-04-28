# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="schemars"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="4cd191f9397d57d581cddd31014772520aa448f65ef991055d7f61582c65165f"
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
