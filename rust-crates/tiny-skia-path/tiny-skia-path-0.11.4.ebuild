# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tiny-skia-path"
CRATE_VERSION="0.11.4"
CRATE_CHECKSUM="9c9e7fc0c2e86a30b117d0462aa261b72b7a99b7ebd7deb3a14ceda95c5bdc93"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tiny-skia Bezier path implementation"
HOMEPAGE="https://github.com/RazrFalcon/tiny-skia/tree/master/path"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"no-std-float"
	"std"
)
