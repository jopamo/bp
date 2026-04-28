# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tar"
CRATE_VERSION="0.4.45"
CRATE_CHECKSUM="22692a6476a21fa75fdfc11d452fda482af402c008cdbaf3476414e122040973"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of a TAR file reader and writer. This library does not currently handle compression, but it is abstract over all I/O readers and writers. Additionally, great lengths are taken to ensure that the entire contents are never required to be entirely resident in memory all at once."
HOMEPAGE="https://github.com/alexcrichton/tar-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
