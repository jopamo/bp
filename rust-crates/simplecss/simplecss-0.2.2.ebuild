# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="simplecss"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="7a9c6883ca9c3c7c90e888de77b7a5c849c779d25d74a1269b0218b14e8b136c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple CSS 2 parser and selector."
HOMEPAGE="https://github.com/linebender/simplecss"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
