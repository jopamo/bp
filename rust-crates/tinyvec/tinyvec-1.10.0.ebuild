# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tinyvec"
CRATE_VERSION="1.10.0"
CRATE_CHECKSUM="bfa5fdc3bce6191a1dbc8c02d5c8bffcf557bafa17c124c5264a458f1b0613fa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="`tinyvec` provides 100% safe vec-like data structures."
HOMEPAGE="https://github.com/Lokathor/tinyvec"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="0/${PV}"
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
	"std"
)
