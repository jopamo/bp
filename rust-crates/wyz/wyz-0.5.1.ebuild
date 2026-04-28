# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wyz"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="05f360fc0b24296329c78fda852a1e9ae82de9cf7b27dae4b7f62f118f77b9ed"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="myrrlyn’s utility collection"
HOMEPAGE="https://myrrlyn.net/crates/wyz"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"garbage"
	"std"
)
