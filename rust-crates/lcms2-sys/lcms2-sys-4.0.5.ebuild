# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lcms2-sys"
CRATE_VERSION="4.0.5"
CRATE_CHECKSUM="593265f9a3172180024fb62580ee31348f31be924b19416da174ebb7fb623d2e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings for liblcms2 (Little CMS) with support for Linux, macOS, and Windows. See lcms2 crate for a safe Rust wrapper."
HOMEPAGE="https://lib.rs/crates/lcms2-sys"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"dynamic"
	"lcms2-strict-cgats"
	"parallel"
	"static"
	"static-fallback"
)
