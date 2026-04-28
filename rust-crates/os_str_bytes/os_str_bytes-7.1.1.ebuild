# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="os_str_bytes"
CRATE_VERSION="7.1.1"
CRATE_CHECKSUM="63eceb7b5d757011a87d08eb2123db15d87fb0c281f65d101ce30a1e96c3ad5c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lossless functionality for platform-native strings"
HOMEPAGE="https://github.com/dylni/os_str_bytes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"checked_conversions"
	"conversions"
	"default"
	"raw_os_str"
)
