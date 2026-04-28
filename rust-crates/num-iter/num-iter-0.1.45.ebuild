# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-iter"
CRATE_VERSION="0.1.45"
CRATE_CHECKSUM="1429034a0490724d0075ebb2bc9e875d6503c3cf69e235a8941aa757d83ef5bf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="External iterators for generic mathematics"
HOMEPAGE="https://github.com/rust-num/num-iter"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"i128"
	"std"
)
