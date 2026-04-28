# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fslock"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="04412b8935272e3a9bae6f48c7bfff74c2911f60525404edfdd28e49884c3bfb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to use files as locks"
HOMEPAGE="https://github.com/brunoczim/fslock"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
