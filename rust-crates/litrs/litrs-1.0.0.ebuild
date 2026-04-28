# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="litrs"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="11d3d7f243d5c5a8b9bb5d6dd2b1602c0cb0b9db1621bafc7ed66e35ff9fe092"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parse and inspect Rust literals (i.e. tokens in the Rust programming language representing fixed values). Particularly useful for proc macros, but can also be used outside of a proc-macro context."
HOMEPAGE="https://github.com/LukasKalbertodt/litrs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"check_suffix"
)
