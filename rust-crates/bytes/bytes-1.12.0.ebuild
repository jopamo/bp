# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bytes"
CRATE_VERSION="1.12.0"
CRATE_CHECKSUM="8ae3f5d315924270530207e2a68396c3cc547f6dca3fbdca317cfb1a51edb593"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Types and traits for working with bytes"
HOMEPAGE="https://github.com/tokio-rs/bytes"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
