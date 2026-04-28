# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tar"
CRATE_VERSION="0.4.43"
CRATE_CHECKSUM="c65998313f8e17d0d553d28f91a0df93e4dbbbf770279c7bc21ca0f09ea1a1f6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of a TAR file reader and writer. This library does not currently handle compression, but it is abstract over all I/O readers and writers. Additionally, great lengths are taken to ensure that the entire contents are never required to be entirely resident in memory all at once."
HOMEPAGE="https://github.com/alexcrichton/tar-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
