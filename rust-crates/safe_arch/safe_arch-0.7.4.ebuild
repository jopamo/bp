# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="safe_arch"
CRATE_VERSION="0.7.4"
CRATE_CHECKSUM="96b02de82ddbe1b636e6170c21be622223aea188ef2e139be0a5b219ec215323"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Crate that exposes \`core::arch\` safely via \`#[cfg()]\`."
HOMEPAGE="https://github.com/Lokathor/safe_arch"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
