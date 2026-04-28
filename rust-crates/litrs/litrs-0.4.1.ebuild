# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="litrs"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="b4ce301924b7887e9d637144fdade93f9dfff9b60981d4ac161db09720d39aa5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parse and inspect Rust literals (i.e. tokens in the Rust programming language representing fixed values). Particularly useful for proc macros, but can also be used outside of a proc-macro context."
HOMEPAGE="https://github.com/LukasKalbertodt/litrs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"check_suffix"
	"default"
)
