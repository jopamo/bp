# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bcrypt-pbkdf"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="6aeac2e1fe888769f34f05ac343bbef98b14d1ffb292ab69d4608b3abc86f2a2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="bcrypt-pbkdf password-based key derivation function"
HOMEPAGE="https://github.com/RustCrypto/password-hashes/tree/master/bcrypt-pbkdf"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
