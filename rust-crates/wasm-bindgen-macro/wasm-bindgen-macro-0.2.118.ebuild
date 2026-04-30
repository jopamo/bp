# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wasm-bindgen-macro"
CRATE_VERSION="0.2.118"
CRATE_CHECKSUM="eeff24f84126c0ec2db7a449f0c2ec963c6a49efe0698c4242929da037ca28ed"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Definition of the \`#[wasm_bindgen]\` attribute, an internal dependency"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"strict-macro"
)
