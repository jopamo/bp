# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="munge_macro"
CRATE_VERSION="0.4.5"
CRATE_CHECKSUM="574af9cd5b9971cbfdf535d6a8d533778481b241c447826d976101e0149392a1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for custom destructuring"
HOMEPAGE="https://github.com/djkoloski/munge"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
