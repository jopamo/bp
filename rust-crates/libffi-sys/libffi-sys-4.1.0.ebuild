# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libffi-sys"
CRATE_VERSION="4.1.0"
CRATE_CHECKSUM="71d4f1d4ce15091955144350b75db16a96d4a63728500122706fb4d29a26afbb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw Rust bindings for libffi"
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
