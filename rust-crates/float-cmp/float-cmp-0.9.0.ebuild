# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="float-cmp"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="98de4bbd547a563b716d8dfa9aad1cb19bfab00f4fa09a6a4ed21dbcf44ce9c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Floating point approximate comparison traits"
HOMEPAGE="https://github.com/mikedilger/float-cmp"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"ratio"
	"std"
)
