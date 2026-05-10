# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="futures-lite"
CRATE_VERSION="2.6.0"
CRATE_CHECKSUM="f5edaec856126859abb19ed65f39e90fea3a9574b9707f13539acf4abf7eb532"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Futures, streams, and async I/O combinators"
HOMEPAGE="https://github.com/smol-rs/futures-lite"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"race"
	"std"
)
