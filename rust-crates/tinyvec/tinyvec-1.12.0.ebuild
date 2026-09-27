# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tinyvec"
CRATE_VERSION="1.12.0"
CRATE_CHECKSUM="bb4ebadaa0af04fab11ae01eb5f9fdb5f9c5b875506e210e71c07873528baa7f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="\`tinyvec\` provides 100% safe vec-like data structures."
HOMEPAGE="https://github.com/Lokathor/tinyvec"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"debugger_visualizer"
	"default"
	"experimental_write_impl"
	"grab_spare_slice"
	"latest_stable_rust"
	"nightly_slice_partition_dedup"
	"real_blackbox"
	"rustc_1_40"
	"rustc_1_55"
	"rustc_1_57"
	"rustc_1_61"
	"schemars"
	"serde"
	"std"
)
