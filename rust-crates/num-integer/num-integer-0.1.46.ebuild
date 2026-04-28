# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-integer"
CRATE_VERSION="0.1.46"
CRATE_CHECKSUM="7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Integer traits and functions"
HOMEPAGE="https://github.com/rust-num/num-integer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"i128"
	"std"
)
