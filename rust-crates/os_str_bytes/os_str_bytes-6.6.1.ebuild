# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="os_str_bytes"
CRATE_VERSION="6.6.1"
CRATE_CHECKSUM="e2355d85b9a3786f481747ced0e0ff2ba35213a1f9bd406ed906554d7af805a1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Convert between byte sequences and platform-native strings"
HOMEPAGE="https://github.com/dylni/os_str_bytes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"checked_conversions"
	"conversions"
	"default"
	"nightly"
	"raw_os_str"
)
