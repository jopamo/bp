# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ena"
CRATE_VERSION="0.14.3"
CRATE_CHECKSUM="3d248bdd43ce613d87415282f69b9bb99d947d290b10962dd6c56233312c2ad5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Union-find, congruence closure, and other unification code. Based on code from rustc."
HOMEPAGE="https://github.com/rust-lang/ena"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench"
	"persistent"
)
