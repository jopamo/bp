# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustc-demangle"
CRATE_VERSION="0.1.24"
CRATE_CHECKSUM="719b953e2095829ee67db738b3bfa9fa368c94900df327b3f07fe6e794d2fe1f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust compiler symbol demangling."
HOMEPAGE="https://github.com/rust-lang/rustc-demangle"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"rustc-dep-of-std"
	"std"
)
