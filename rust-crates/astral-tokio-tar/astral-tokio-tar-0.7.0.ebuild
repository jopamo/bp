# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral-tokio-tar"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="6f2e989b33246fe9240d39accf4dd9a01e0b6c1f3ce9dd095e0a47fa02505523"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of an async TAR file reader and writer. This library does not currently handle compression, but it is abstract over all I/O readers and writers. Additionally, great lengths are taken to ensure that the entire contents are never required to be entirely resident in memory all at once."
HOMEPAGE="https://github.com/astral-sh/tokio-tar"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
