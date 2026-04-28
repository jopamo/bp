# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tiny-skia"
CRATE_VERSION="0.11.4"
CRATE_CHECKSUM="83d13394d44dae3207b52a326c0c85a8bf87f1541f23b0d143811088497b09ab"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tiny Skia subset ported to Rust."
HOMEPAGE="https://github.com/RazrFalcon/tiny-skia"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"no-std-float"
	"png-format"
	"simd"
	"std"
)
