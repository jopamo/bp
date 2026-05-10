# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wmi"
CRATE_VERSION="0.16.0"
CRATE_CHECKSUM="5d9189bc72f0e4d814d812216ec06636ce3ea5597ff5f1ff9f9f0e5ec781c027"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WMI crate for rust."
HOMEPAGE="https://github.com/ohadravid/wmi-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"test"
)
