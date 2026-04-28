# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="float-cmp"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="b09cf3155332e944990140d967ff5eceb70df778b34f77d8075db46e4704e6d8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Floating point approximate comparison traits"
HOMEPAGE="https://github.com/mikedilger/float-cmp"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"ratio"
	"std"
)
