# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="derive_more"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="093242cf7570c207c83073cf82f79706fe7b8317e98620a47d5be7c3d8497678"
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
	"std"
	"sum"
	"testing-helpers"
	"try_from"
	"try_into"
	"try_unwrap"
	"unwrap"
)
