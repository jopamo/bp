# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="synstructure"
CRATE_VERSION="0.13.2"
CRATE_CHECKSUM="728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper methods and macros for custom derives"
HOMEPAGE="https://github.com/mystor/synstructure"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"proc-macro"
)
