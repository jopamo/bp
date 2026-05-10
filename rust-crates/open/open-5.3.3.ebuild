# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="open"
CRATE_VERSION="5.3.3"
CRATE_CHECKSUM="43bb73a7fa3799b198970490a51174027ba0d4ec504b03cd08caf513d40024bc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Open a path or URL using the program configured on the system"
HOMEPAGE="https://github.com/Byron/open-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"shellexecute-on-windows"
)
