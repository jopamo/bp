# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-xwin"
CRATE_VERSION="0.23.1"
CRATE_CHECKSUM="08fe6fef95319ecc03c40127b2af811522b7918b05502ebb35b2972208993a57"
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
