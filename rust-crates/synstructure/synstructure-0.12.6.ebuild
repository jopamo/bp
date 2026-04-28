# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="synstructure"
CRATE_VERSION="0.12.6"
CRATE_CHECKSUM="f36bdaa60a83aca3921b5259d5400cbf5e90fc51931376a9bd4a0eb79aa7210f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper methods and macros for custom derives"
HOMEPAGE="https://github.com/mystor/synstructure"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"proc-macro"
)
