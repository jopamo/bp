# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="cpp_demangle"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="0667304c32ea56cb4cd6d2d7c0cfe9a2f8041229db8c033af7f8d69492429def"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate for demangling C++ symbols"
HOMEPAGE="https://github.com/gimli-rs/cpp_demangle"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"fuzz"
	"logging"
	"run_libiberty_tests"
	"std"
)
