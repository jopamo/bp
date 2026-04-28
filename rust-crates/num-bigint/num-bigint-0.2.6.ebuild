# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-bigint"
CRATE_VERSION="0.2.6"
CRATE_CHECKSUM="090c7f9998ee0ff65aa5b723e4009f7b217707f1fb5ea551329cc4d6231fb304"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Big integer implementation for Rust"
HOMEPAGE="https://github.com/rust-num/num-bigint"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"i128"
	"std"
)
