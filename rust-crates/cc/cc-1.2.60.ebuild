# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cc"
CRATE_VERSION="1.2.60"
CRATE_CHECKSUM="43c5703da9466b66a946814e1adf53ea2c90f10063b86290cc9eb67ce3478a20"
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
