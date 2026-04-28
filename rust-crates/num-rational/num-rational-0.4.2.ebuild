# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-rational"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="f83d14da390562dca69fc84082e73e548e1ad308d24accdedd2720017cb37824"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rational numbers implementation for Rust"
HOMEPAGE="https://github.com/rust-num/num-rational"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"num-bigint"
	"num-bigint-std"
	"serde"
	"std"
)
