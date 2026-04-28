# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strck"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="42316e70da376f3d113a68d138a60d8a9883c604fe97942721ec2068dab13a9f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Checked owned and borrowed strings"
HOMEPAGE="https://github.com/QnnOkabayashi/strck"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ident"
)
