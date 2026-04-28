# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="shell-words"
CRATE_VERSION="1.1.1"
CRATE_CHECKSUM="dc6fe69c597f9c37bfeeeeeb33da3530379845f10be461a66d16d03eca2ded77"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Process command line according to parsing rules of UNIX shell"
HOMEPAGE="https://github.com/tmiasko/shell-words"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
