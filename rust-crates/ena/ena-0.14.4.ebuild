# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ena"
CRATE_VERSION="0.14.4"
CRATE_CHECKSUM="eabffdaee24bd1bf95c5ef7cec31260444317e72ea56c4c91750e8b7ee58d5f1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Union-find, congruence closure, and other unification code. Based on code from rustc."
HOMEPAGE="https://github.com/rust-lang/ena"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench"
	"persistent"
)
