# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hkdf"
CRATE_VERSION="0.12.4"
CRATE_CHECKSUM="7b5f8eb2ad728638ea2c7d47a21db23b7b58a72ed6a38256b8a1849f15fbbdf7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="HMAC-based Extract-and-Expand Key Derivation Function (HKDF)"
HOMEPAGE="https://github.com/RustCrypto/KDFs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
