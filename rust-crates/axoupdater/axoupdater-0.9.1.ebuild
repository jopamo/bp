# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="axoupdater"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="dc482a1926df098f4e3806b834f3fe73a1ab54b24ab0ac481f72de479af5e982"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Self-updater library for use with cargo-dist"
HOMEPAGE="https://github.com/axodotdev/axoupdater"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"axo_releases"
	"blocking"
	"default"
	"github_releases"
	"tls_native_roots"
)
