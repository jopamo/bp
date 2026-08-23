# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="embedded-io"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="ef1a6892d9eef45c8fa6b9e0086428a2cca8491aca8f787c534a3d6d0bcb3ced"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Embedded IO traits"
HOMEPAGE="https://github.com/embassy-rs/embedded-io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"async"
	"futures"
	"std"
	"tokio"
)
