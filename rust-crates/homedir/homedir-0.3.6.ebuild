# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="homedir"
CRATE_VERSION="0.3.6"
CRATE_CHECKSUM="68df315d2857b2d8d2898be54a85e1d001bbbe0dbb5f8ef847b48dd3a23c4527"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate to help get the home directory of any user on a system."
HOMEPAGE="https://jamespetersen.ca/homedir"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"windows-coinitialize"
)
