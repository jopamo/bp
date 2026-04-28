# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="matchers"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="d1525a2a28c7f4fa0fc98bb91ae755d1e2d1505079e05539e35bc876b5d65ae9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Regex matching on character and byte streams."
HOMEPAGE="https://github.com/hawkw/matchers"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"unicode"
)
