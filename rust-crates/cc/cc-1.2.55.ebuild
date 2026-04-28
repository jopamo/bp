# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cc"
CRATE_VERSION="1.2.55"
CRATE_CHECKSUM="47b26a0954ae34af09b50f0de26458fa95369a0d478d8236d3f93082b219bd29"
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
