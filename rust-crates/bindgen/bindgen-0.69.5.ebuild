# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bindgen"
CRATE_VERSION="0.69.5"
CRATE_CHECKSUM="271383c67ccabffb7381723dea0672a673f292304fcb45c01cc648c7a8d58088"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically generates Rust FFI bindings to C and C++ libraries."
HOMEPAGE="https://rust-lang.github.io/rust-bindgen/"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__cli"
	"__testing_only_extra_assertions"
	"__testing_only_libclang_16"
	"__testing_only_libclang_9"
	"default"
	"experimental"
	"logging"
	"runtime"
	"static"
	"which-rustfmt"
)
