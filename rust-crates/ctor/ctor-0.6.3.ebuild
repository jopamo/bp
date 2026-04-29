# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="ctor"
CRATE_VERSION="0.6.3"
CRATE_CHECKSUM="424e0138278faeb2b401f174ad17e715c829512d74f3d1e81eb43365c2e0590e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="__attribute__((constructor)) for Rust"
HOMEPAGE="https://github.com/mmastrac/rust-ctor"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__no_warn_on_missing_unsafe"
	"default"
	"dtor"
	"proc_macro"
	"used_linker"
)
