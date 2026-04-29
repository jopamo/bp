# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="konst"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="f660d5f887e3562f9ab6f4a14988795b694099d66b4f5dedc02d197ba9becb1d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Const equivalents of std features: comparison, destructuring, iteration, and parsing"
HOMEPAGE="https://github.com/rodrimati1992/konst/"
LICENSE="Zlib"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__ui"
	"alloc"
	"cmp"
	"const_panic_derive"
	"debug"
	"default"
	"docsrs"
	"iter"
	"konst_proc_macros"
	"parsing"
	"parsing_proc"
	"rust_latest_stable"
)
