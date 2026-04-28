# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="derive_more"
CRATE_VERSION="0.99.17"
CRATE_CHECKSUM="4fb810d30a7c1953f91334de7244731fc3f3c10d7fe163338a35b9f640960321"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Adds #[derive(x)] macros for more traits"
HOMEPAGE="https://github.com/JelteF/derive_more"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"add"
	"add_assign"
	"as_mut"
	"as_ref"
	"constructor"
	"default"
	"deref"
	"deref_mut"
	"display"
	"error"
	"from"
	"from_str"
	"generate-parsing-rs"
	"index"
	"index_mut"
	"into"
	"into_iterator"
	"is_variant"
	"iterator"
	"mul"
	"mul_assign"
	"nightly"
	"not"
	"sum"
	"testing-helpers"
	"track-caller"
	"try_into"
	"unwrap"
)
