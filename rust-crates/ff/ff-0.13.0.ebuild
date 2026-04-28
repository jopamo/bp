# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ff"
CRATE_VERSION="0.13.0"
CRATE_CHECKSUM="ded41244b729663b1e574f1b4fb731469f69f79c17667b5d776b16cda0479449"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for building and interfacing with finite fields"
HOMEPAGE="https://github.com/zkcrypto/ff"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"bits"
	"default"
	"derive"
	"derive_bits"
	"std"
)
