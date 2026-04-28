# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ryu"
CRATE_VERSION="1.0.17"
CRATE_CHECKSUM="e86697c916019a8588c99b5fac3cead74ec0b4b819707a682fd4d23fa0ce1ba1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast floating point to string conversion"
HOMEPAGE="https://github.com/dtolnay/ryu"
LICENSE="|| ( Apache-2.0 BSL-1.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"small"
)
