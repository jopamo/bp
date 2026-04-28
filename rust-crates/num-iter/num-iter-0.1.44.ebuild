# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-iter"
CRATE_VERSION="0.1.44"
CRATE_CHECKSUM="d869c01cc0c455284163fd0092f1f93835385ccab5a98a0dcc497b2f8bf055a9"
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
