# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ryu-js"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="ad97d4ce1560a5e27cec89519dc8300d1aa6035b099821261c651486a19e44d5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast floating point to string conversion, ECMAScript compliant."
HOMEPAGE="https://github.com/boa-dev/ryu-js"
LICENSE="|| ( Apache-2.0 BSL-1.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"small"
)
