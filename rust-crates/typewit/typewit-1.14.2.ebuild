# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="typewit"
CRATE_VERSION="1.14.2"
CRATE_CHECKSUM="f8c1ae7cc0fdb8b842d65d127cb981574b0d2b249b74d1c7a2986863dc134f71"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="type-witness-based abstractions, mostly for emulating polymorphism in const fns"
HOMEPAGE="https://github.com/rodrimati1992/typewit/"
LICENSE="Zlib"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__test_doc_lints"
	"__ui_tests"
	"adt_const_marker"
	"alloc"
	"const_marker"
	"default"
	"docsrs"
	"generic_const_exprs"
	"mut_refs"
	"nightly_mut_refs"
	"proc_macros"
	"rust_1_61"
	"rust_1_65"
	"rust_1_83"
	"rust_stable"
)
