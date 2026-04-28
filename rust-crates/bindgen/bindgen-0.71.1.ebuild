# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bindgen"
CRATE_VERSION="0.71.1"
CRATE_CHECKSUM="5f58bf3d7db68cfbac37cfc485a8d711e87e064c3d0fe0435b92f7a407f9d6b3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically generates Rust FFI bindings to C and C++ libraries."
HOMEPAGE="https://rust-lang.github.io/rust-bindgen/"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
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
