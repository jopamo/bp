# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="data-encoding"
CRATE_VERSION="2.9.0"
CRATE_CHECKSUM="2a2330da5de22e8a3cb63252ce2abb30116bf5265e89c0e01bc17015ce30a476"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Efficient and customizable data-encoding functions like base64, base32, and hex"
HOMEPAGE="https://github.com/ia0/data-encoding"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
