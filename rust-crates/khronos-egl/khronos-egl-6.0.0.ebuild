# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="khronos-egl"
CRATE_VERSION="6.0.0"
CRATE_CHECKSUM="6aae1df220ece3c0ada96b8153459b67eebe9ae9212258bb0134ae60416fdf76"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings for EGL"
HOMEPAGE="https://github.com/timothee-haudebourg/khronos-egl"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"1_0"
	"1_1"
	"1_2"
	"1_3"
	"1_4"
	"1_5"
	"default"
	"dynamic"
	"no-pkg-config"
	"static"
)
