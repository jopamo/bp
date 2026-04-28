# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cbc"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="26b52a9543ae338f279b96b0b9fed9c8093744685043739079ce85cd58f289a6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cipher Block Chaining (CBC) block cipher mode of operation"
HOMEPAGE="https://github.com/RustCrypto/block-modes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"block-padding"
	"default"
	"std"
	"zeroize"
)
