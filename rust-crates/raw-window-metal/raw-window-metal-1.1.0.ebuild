# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="raw-window-metal"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="40d213455a5f1dc59214213c7330e074ddf8114c9a42411eb890c767357ce135"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Interop library between Metal and raw-window-handle"
HOMEPAGE="https://github.com/rust-windowing/raw-window-metal"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
