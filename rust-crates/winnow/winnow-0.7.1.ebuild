# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winnow"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="86e376c75f4f43f44db463cf729e0d3acbf954d13e22c51e26e4c264b4ab545f"
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
