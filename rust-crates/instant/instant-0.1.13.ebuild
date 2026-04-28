# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="instant"
CRATE_VERSION="0.1.13"
CRATE_CHECKSUM="e0242819d153cba4b4b05a5a8f2a7e9bbf97b6055b2a002b395c96b5ff3c0222"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unmaintained, consider using web-time instead - A partial replacement for std::time::Instant that works on WASM to."
HOMEPAGE="https://github.com/sebcrozet/instant"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"inaccurate"
	"now"
	"wasm-bindgen"
)
