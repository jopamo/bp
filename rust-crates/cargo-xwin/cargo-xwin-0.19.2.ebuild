# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo-xwin"
CRATE_VERSION="0.19.2"
CRATE_CHECKSUM="44f9aad85446b44556fc1afd2b1110b1f7bac3d61d67f38f83bcb4bf6ab3d9ac"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross compile Cargo project to Windows MSVC target with ease"
HOMEPAGE="https://github.com/rust-cross/cargo-xwin"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"native-tls"
	"rustls-tls"
)
