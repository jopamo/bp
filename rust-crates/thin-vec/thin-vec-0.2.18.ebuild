# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="thin-vec"
CRATE_VERSION="0.2.18"
CRATE_CHECKSUM="b0f7e269b48f0a7dd0146680fa24b50cc67fc0373f086a5b2f99bd084639b482"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Vec that takes up less space on the stack."
HOMEPAGE="https://github.com/mozilla/thin-vec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const_new"
	"default"
	"gecko-ffi"
	"std"
	"unstable"
)
