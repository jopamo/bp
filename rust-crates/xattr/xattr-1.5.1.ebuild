# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="xattr"
CRATE_VERSION="1.5.1"
CRATE_CHECKSUM="af3a19837351dc82ba89f8a125e22a3c475f05aba604acc023d62b2739ae2909"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="unix extended filesystem attributes"
HOMEPAGE="https://github.com/Stebalien/xattr"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"unsupported"
)
