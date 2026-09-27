# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="num-bigint"
CRATE_VERSION="0.4.8"
CRATE_CHECKSUM="c89e69e7e0f03bea5ef08013795c25018e101932225a656383bd384495ecc367"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Big integer implementation for Rust"
HOMEPAGE="https://github.com/rust-num/num-bigint"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"default"
	"quickcheck"
	"rand"
	"serde"
	"std"
)
