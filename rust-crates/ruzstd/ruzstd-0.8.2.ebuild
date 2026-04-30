# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ruzstd"
CRATE_VERSION="0.8.2"
CRATE_CHECKSUM="e5ff0cc5e135c8870a775d3320910cd9b564ec036b4dc0b8741629020be63f01"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A decoder for the zstd compression format"
HOMEPAGE="https://github.com/KillingSpark/zstd-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"dict_builder"
	"fuzz_exports"
	"hash"
	"rustc-dep-of-std"
	"std"
)
