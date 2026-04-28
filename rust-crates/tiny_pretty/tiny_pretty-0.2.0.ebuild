# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tiny_pretty"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="4b3f46f0549180b9c6f7f76270903f1a06867c43a03998b99dce81aa1760c3b2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tiny implementation of Wadler-style pretty printer."
HOMEPAGE="https://github.com/g-plane/tiny_pretty"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"unicode-width"
)
