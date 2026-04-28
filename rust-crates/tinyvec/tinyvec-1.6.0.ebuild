# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tinyvec"
CRATE_VERSION="1.6.0"
CRATE_CHECKSUM="87cc5ceb3875bb20c2890005a4e226a4651264a5c75edb2421b52861a0a0cb50"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="`tinyvec` provides 100% safe vec-like data structures."
HOMEPAGE="https://github.com/Lokathor/tinyvec"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"experimental_write_impl"
	"grab_spare_slice"
	"nightly_slice_partition_dedup"
	"real_blackbox"
	"rustc_1_40"
	"rustc_1_55"
	"rustc_1_57"
	"std"
)
