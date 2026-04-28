# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="error-code"
CRATE_VERSION="3.3.2"
CRATE_CHECKSUM="dea2df4cf52843e0452895c455a1a2cfbb842a1e7329671acf418fdc53ed4c59"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Error code"
HOMEPAGE="https://github.com/DoumanAsh/error-code"
LICENSE="BSL-1.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
