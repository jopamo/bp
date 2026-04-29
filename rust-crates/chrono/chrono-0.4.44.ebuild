# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="chrono"
CRATE_VERSION="0.4.44"
CRATE_CHECKSUM="c673075a2e0e5f4a1dde27ce9dee1ea4558c7ffe648f576438a20ca1d2acc4b0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Date and time library for Rust"
HOMEPAGE="https://github.com/chronotope/chrono"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__internal_bench"
	"alloc"
	"clock"
	"core-error"
	"default"
	"defmt"
	"libc"
	"now"
	"oldtime"
	"rkyv"
	"rkyv-16"
	"rkyv-32"
	"rkyv-64"
	"rkyv-validation"
	"std"
	"unstable-locales"
	"wasmbind"
	"winapi"
)
