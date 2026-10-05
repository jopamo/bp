# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libffi"
CRATE_VERSION="5.1.0"
CRATE_CHECKSUM="0498fe5655f857803e156523e644dcdcdc3b3c7edda42ea2afdae2e09b2db87b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings for libffi"
HOMEPAGE="https://github.com/libffi-rs/libffi-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"check_only"
	"complex"
	"default"
	"std"
	"system"
)
