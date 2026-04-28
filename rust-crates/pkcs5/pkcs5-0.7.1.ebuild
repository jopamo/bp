# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pkcs5"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="e847e2c91a18bfa887dd028ec33f2fe6f25db77db3619024764914affe8b69a6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of Public-Key Cryptography Standards (PKCS) #5: Password-Based Cryptography Specification Version 2.1 (RFC 8018)"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/pkcs5"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"3des"
	"alloc"
	"des-insecure"
	"pbes2"
	"sha1-insecure"
)
