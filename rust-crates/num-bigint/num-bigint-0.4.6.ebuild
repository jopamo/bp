# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-bigint"
CRATE_VERSION="0.4.6"
CRATE_CHECKSUM="a5e44f723f1133c9deac646763579fdb3ac745e418f2a7af9cd0c431da1f20b9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Big integer implementation for Rust"
HOMEPAGE="https://github.com/rust-num/num-bigint"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"default"
	"quickcheck"
	"rand"
	"serde"
	"std"
)
