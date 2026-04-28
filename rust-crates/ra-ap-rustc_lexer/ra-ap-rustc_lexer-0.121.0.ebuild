# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra-ap-rustc_lexer"
CRATE_VERSION="0.121.0"
CRATE_CHECKSUM="22944e31fb91e9b3e75bcbc91e37d958b8c0825a6160927f2856831d2ce83b36"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically published version of the package \`rustc_lexer\` in the rust-lang/rust repository from commit d2baa49a106fad06fbf6202fb6ea8a0b3d2767cc The publishing script for this crate lives at: https://github.com/rust-analyzer/rustc-auto-publish"
HOMEPAGE="https://github.com/rust-lang/rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
