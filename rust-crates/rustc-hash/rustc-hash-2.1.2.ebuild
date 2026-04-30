# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustc-hash"
CRATE_VERSION="2.1.2"
CRATE_CHECKSUM="94300abf3f1ae2e2b8ffb7b58043de3d399c73fa6f4b73826402a5c457614dbe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A speedy, non-cryptographic hashing algorithm used by rustc"
HOMEPAGE="https://github.com/rust-lang/rustc-hash"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"rand"
	"std"
)
