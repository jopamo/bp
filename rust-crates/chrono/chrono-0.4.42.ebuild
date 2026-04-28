# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="chrono"
CRATE_VERSION="0.4.42"
CRATE_CHECKSUM="145052bdd345b87320e369255277e3fb5152762ad123a901ef5c262dd38fe8d2"
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
