# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="num-bigint-dig"
CRATE_VERSION="0.8.6"
CRATE_CHECKSUM="e661dda6640fad38e827a6d4a310ff4763082116fe217f279885c97f511bb0b7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Big integer implementation for Rust"
HOMEPAGE="https://github.com/dignifiedquire/num-bigint"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
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
