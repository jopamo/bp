# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cc"
CRATE_VERSION="1.0.96"
CRATE_CHECKSUM="065a29261d53ba54260972629f9ca6bffa69bac13cd1fed61420f7fa68b9f8bd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A build-time dependency for Cargo build scripts to assist in invoking the native C compiler to compile native C code into a static archive to be linked into Rust code."
HOMEPAGE="https://github.com/rust-lang/cc-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"parallel"
)
