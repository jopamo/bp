# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-rational"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="5c000134b5dbf44adc5cb772486d335293351644b801551abe8f75c84cfa4aef"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rational numbers implementation for Rust"
HOMEPAGE="https://github.com/rust-num/num-rational"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bigint"
	"bigint-std"
	"default"
	"i128"
	"std"
)
