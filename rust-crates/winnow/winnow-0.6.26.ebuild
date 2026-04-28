# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winnow"
CRATE_VERSION="0.6.26"
CRATE_CHECKSUM="1e90edd2ac1aa278a5c4599b1d89cf03074b610800f866d4026dc199d7929a28"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A byte-oriented, zero-copy, parser combinators library"
HOMEPAGE="https://github.com/winnow-rs/winnow"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"debug"
	"default"
	"simd"
	"std"
	"unstable-doc"
	"unstable-recover"
)
