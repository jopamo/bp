# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fiat-crypto"
CRATE_VERSION="0.1.20"
CRATE_CHECKSUM="e825f6987101665dea6ec934c09ec6d721de7bc1bf92248e1d5810c8cd636b77"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fiat-crypto generated Rust"
HOMEPAGE="https://github.com/mit-plv/fiat-crypto"
LICENSE="|| ( MIT Apache-2.0 BSD-1-Clause )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
