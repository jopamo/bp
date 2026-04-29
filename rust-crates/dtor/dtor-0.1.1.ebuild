# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="dtor"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="404d02eeb088a82cfd873006cb713fe411306c7d182c344905e101fb1167d301"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="__attribute__((destructor)) for Rust"
HOMEPAGE="https://github.com/mmastrac/rust-ctor"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__no_warn_on_missing_unsafe"
	"default"
	"proc_macro"
	"used_linker"
)
