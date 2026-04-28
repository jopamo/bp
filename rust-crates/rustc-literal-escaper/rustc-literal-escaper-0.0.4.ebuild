# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustc-literal-escaper"
CRATE_VERSION="0.0.4"
CRATE_CHECKSUM="ab03008eb631b703dd16978282ae36c73282e7922fe101a4bd072a40ecea7b8b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides code to unescape string literals"
HOMEPAGE="https://github.com/rust-lang/literal-escaper"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"rustc-dep-of-std"
)
