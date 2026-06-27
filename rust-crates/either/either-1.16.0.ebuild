# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="either"
CRATE_VERSION="1.16.0"
CRATE_CHECKSUM="91622ff5e7162018101f2fea40d6ebf4a78bbe5a49736a2020649edf9693679e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The enum \`Either\` with variants \`Left\` and \`Right\` is a general purpose sum type with two cases."
HOMEPAGE="https://github.com/rayon-rs/either"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"use_std"
)
