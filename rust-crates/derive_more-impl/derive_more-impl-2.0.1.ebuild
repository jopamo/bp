# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="derive_more-impl"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="bda628edc44c4bb645fbe0f758797143e4e07926f7ebf4e9bdfbd3d2ce621df3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Internal implementation of `derive_more` crate"
HOMEPAGE="https://github.com/JelteF/derive_more"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"add"
	"add_assign"
	"as_ref"
	"constructor"
	"debug"
	"default"
	"deref"
	"deref_mut"
	"display"
	"error"
	"from"
	"from_str"
	"full"
	"index"
	"index_mut"
	"into"
	"into_iterator"
	"is_variant"
	"mul"
	"mul_assign"
	"not"
	"sum"
	"testing-helpers"
	"try_from"
	"try_into"
	"try_unwrap"
	"unwrap"
)
