# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tracing"
CRATE_VERSION="0.1.41"
CRATE_CHECKSUM="784e0ac535deb450455cbfa28a6f0df145ea1bb7ae51b821cf5e7927fdcfbdd0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Application-level tracing for Rust."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-await"
	"attributes"
	"default"
	"log-always"
	"max_level_debug"
	"max_level_error"
	"max_level_info"
	"max_level_off"
	"max_level_trace"
	"max_level_warn"
	"release_max_level_debug"
	"release_max_level_error"
	"release_max_level_info"
	"release_max_level_off"
	"release_max_level_trace"
	"release_max_level_warn"
	"std"
	"valuable"
)
