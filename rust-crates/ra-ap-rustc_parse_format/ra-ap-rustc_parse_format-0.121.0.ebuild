# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra-ap-rustc_parse_format"
CRATE_VERSION="0.121.0"
CRATE_CHECKSUM="81057891bc2063ad9e353f29462fbc47a0f5072560af34428ae9313aaa5e9d97"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically published version of the package \`rustc_parse_format\` in the rust-lang/rust repository from commit d2baa49a106fad06fbf6202fb6ea8a0b3d2767cc The publishing script for this crate lives at: https://github.com/rust-analyzer/rustc-auto-publish"
HOMEPAGE="https://github.com/rust-lang/rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
