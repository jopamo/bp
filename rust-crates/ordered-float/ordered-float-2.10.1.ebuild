# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ordered-float"
CRATE_VERSION="2.10.1"
CRATE_CHECKSUM="68f19d67e5a2795c94e73e0bb1cc1a7edeb2e28efd39e2e1c9b7a40c1108b11c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Wrappers for total ordering on floats"
HOMEPAGE="https://github.com/reem/rust-ordered-float"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"randtest"
	"std"
)
