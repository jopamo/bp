# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ignore"
CRATE_VERSION="0.4.25"
CRATE_CHECKSUM="d3d782a365a015e0f5c04902246139249abf769125006fbe7649e2ee88169b4a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast library for efficiently matching ignore files such as \`.gitignore\` against file paths."
HOMEPAGE="https://github.com/BurntSushi/ripgrep/tree/master/crates/ignore"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"simd-accel"
)
