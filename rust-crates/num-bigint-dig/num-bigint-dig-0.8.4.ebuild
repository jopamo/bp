# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-bigint-dig"
CRATE_VERSION="0.8.4"
CRATE_CHECKSUM="dc84195820f291c7697304f3cbdadd1cb7199c0efc917ff5eafd71225c136151"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Big integer implementation for Rust"
HOMEPAGE="https://github.com/dignifiedquire/num-bigint"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"fuzz"
	"i128"
	"nightly"
	"prime"
	"std"
	"u64_digit"
)
