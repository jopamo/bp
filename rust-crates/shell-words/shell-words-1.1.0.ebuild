# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="shell-words"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="24188a676b6ae68c3b2cb3a01be17fbf7240ce009799bb56d5b1409051e78fde"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Process command line according to parsing rules of UNIX shell"
HOMEPAGE="https://github.com/tmiasko/shell-words"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
