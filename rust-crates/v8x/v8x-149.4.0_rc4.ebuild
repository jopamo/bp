# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="v8x"
CRATE_VERSION="149.4.0-rc.4"
CRATE_CHECKSUM="3701ffb3692a24808503d17f758b0a3f688d2c451779247982566b5941033e63"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Engine agnostic JavaScript"
HOMEPAGE="https://github.com/littledivy/v8x"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"engine_jsc"
	"engine_quickjs"
	"jsc"
	"link_quickjs"
	"quickjs"
	"simdutf"
	"system_jsc"
	"use_custom_libcxx"
	"v8_enable_pointer_compression"
	"v8_enable_sandbox"
	"v8_enable_v8_checks"
	"vendor_jsc"
)
