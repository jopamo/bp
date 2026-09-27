# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bytes"
CRATE_VERSION="1.12.1"
CRATE_CHECKSUM="fc652a48c352aef3ea3aed32080501cf3ef6ed5da78602a020c991775b0aff04"
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
