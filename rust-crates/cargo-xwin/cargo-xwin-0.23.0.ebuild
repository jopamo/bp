# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-xwin"
CRATE_VERSION="0.23.0"
CRATE_CHECKSUM="22a978d433c17ee532d4cb0a8ec9b7aeb121e658267ac1c637504583b12b2861"
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
