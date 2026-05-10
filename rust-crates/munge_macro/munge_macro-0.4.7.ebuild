# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="munge_macro"
CRATE_VERSION="0.4.7"
CRATE_CHECKSUM="4568f25ccbd45ab5d5603dc34318c1ec56b117531781260002151b8530a9f931"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for custom destructuring"
HOMEPAGE="https://github.com/djkoloski/munge"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
