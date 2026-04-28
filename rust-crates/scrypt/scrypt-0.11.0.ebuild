# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="scrypt"
CRATE_VERSION="0.11.0"
CRATE_CHECKSUM="0516a385866c09368f0b5bcd1caff3366aace790fcd46e2bb032697bb172fd1f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Scrypt password-based key derivation function"
HOMEPAGE="https://github.com/RustCrypto/password-hashes/tree/master/scrypt"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"simple"
	"std"
)
