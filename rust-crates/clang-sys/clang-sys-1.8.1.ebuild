# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clang-sys"
CRATE_VERSION="1.8.1"
CRATE_CHECKSUM="0b023947811758c97c59bf9d1c188fd619ad4718dcaa767947df1cadb14f39f4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings for libclang."
HOMEPAGE="https://github.com/KyleMayes/clang-sys"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"clang_10_0"
	"clang_11_0"
	"clang_12_0"
	"clang_13_0"
	"clang_14_0"
	"clang_15_0"
	"clang_16_0"
	"clang_17_0"
	"clang_18_0"
	"clang_3_5"
	"clang_3_6"
	"clang_3_7"
	"clang_3_8"
	"clang_3_9"
	"clang_4_0"
	"clang_5_0"
	"clang_6_0"
	"clang_7_0"
	"clang_8_0"
	"clang_9_0"
	"libcpp"
	"runtime"
	"static"
)
