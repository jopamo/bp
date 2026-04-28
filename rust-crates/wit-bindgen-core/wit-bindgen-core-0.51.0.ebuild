# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wit-bindgen-core"
CRATE_VERSION="0.51.0"
CRATE_CHECKSUM="ea61de684c3ea68cb082b7a88508a8b27fcc8b797d738bfc99a82facf1d752dc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low-level support for bindings generation based on WIT files for use with \`wit-bindgen-cli\` and other languages."
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"clap"
	"serde"
)
