# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="futures-macro"
CRATE_VERSION="0.3.34"
CRATE_CHECKSUM="9fb9654ba8355388abeb8dcb4fc62f511300867002afc858860463bdd9fe0c44"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The futures-rs procedural macro implementations."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
