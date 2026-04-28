# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sourcemap"
CRATE_VERSION="9.2.0"
CRATE_CHECKSUM="dd430118acc9fdd838557649b9b43fd0a78e3834d84a283b466f8e84720d6101"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Basic sourcemap handling for Rust"
HOMEPAGE="https://github.com/getsentry/rust-sourcemap"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ram_bundle"
)
