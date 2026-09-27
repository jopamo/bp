# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="chrono"
CRATE_VERSION="0.4.45"
CRATE_CHECKSUM="1aa79e62e7697b8e29b513a68abacf485adcd1fe8284a4316c5ae868e6633327"
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
