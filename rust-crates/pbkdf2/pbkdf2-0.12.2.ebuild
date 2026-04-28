# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pbkdf2"
CRATE_VERSION="0.12.2"
CRATE_CHECKSUM="f8ed6a7761f76e3b9f92dfb0a60a6a6477c61024b775147ff0973a02653abaf2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generic implementation of PBKDF2"
HOMEPAGE="https://github.com/RustCrypto/password-hashes/tree/master/pbkdf2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"parallel"
	"simple"
	"std"
)
