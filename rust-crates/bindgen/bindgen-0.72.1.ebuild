# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bindgen"
CRATE_VERSION="0.72.1"
CRATE_CHECKSUM="993776b509cfb49c750f11b8f07a46fa23e0a1386ffc01fb1e7d343efc387895"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically generates Rust FFI bindings to C and C++ libraries."
HOMEPAGE="https://rust-lang.github.io/rust-bindgen/"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
)
