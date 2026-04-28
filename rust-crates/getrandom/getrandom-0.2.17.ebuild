# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="getrandom"
CRATE_VERSION="0.2.17"
CRATE_CHECKSUM="ff2abc00be7fca6ebc474524697ae276ad847ad0a6b3faa4bcb027e9a4614ad0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A small cross-platform library for retrieving random data from system source"
HOMEPAGE="https://github.com/rust-random/getrandom"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"custom"
	"js"
	"linux_disable_fallback"
	"rdrand"
	"rustc-dep-of-std"
	"std"
	"test-in-browser"
)
