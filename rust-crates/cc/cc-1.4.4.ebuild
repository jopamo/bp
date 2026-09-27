# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cc"
CRATE_VERSION="1.4.4"
CRATE_CHECKSUM="0ad534f4357a5264cce5019c989cf66a4f0dc4e0d1b1d15f8aacec0ff7360273"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A build-time dependency for Cargo build scripts to assist in invoking the native C compiler to compile native C code into a static archive to be linked into Rust code."
HOMEPAGE="https://github.com/rust-lang/cc-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"jobserver"
	"parallel"
)
