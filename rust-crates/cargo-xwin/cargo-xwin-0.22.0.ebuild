# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-xwin"
CRATE_VERSION="0.22.0"
CRATE_CHECKSUM="c010a0e90e1dc09a90428c8768808bb4ad8cd7523e4df38719418e14579a9e37"
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
