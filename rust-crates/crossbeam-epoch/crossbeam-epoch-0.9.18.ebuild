# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crossbeam-epoch"
CRATE_VERSION="0.9.18"
CRATE_CHECKSUM="5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Epoch-based garbage collection"
HOMEPAGE="https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-epoch"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"loom"
	"nightly"
	"std"
)
