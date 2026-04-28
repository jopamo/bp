# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cc"
CRATE_VERSION="1.2.41"
CRATE_CHECKSUM="ac9fe6cdbb24b6ade63616c0a0688e45bb56732262c158df3c0c4bea4ca47cb7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A build-time dependency for Cargo build scripts to assist in invoking the native C compiler to compile native C code into a static archive to be linked into Rust code."
HOMEPAGE="https://github.com/rust-lang/cc-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"jobserver"
	"parallel"
)
