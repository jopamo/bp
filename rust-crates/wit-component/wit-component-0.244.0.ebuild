# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wit-component"
CRATE_VERSION="0.244.0"
CRATE_CHECKSUM="9d66ea20e9553b30172b5e831994e35fbde2d165325bec84fc43dbf6f4eb9cb2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tooling for working with \`*.wit\` and component files together."
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wit-component"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"dummy-module"
	"semver-check"
	"wat"
)
