# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crypto-bigint"
CRATE_VERSION="0.5.5"
CRATE_CHECKSUM="0dc92fb57ca44df6db8059111ab3af99a63d5d0f8375d9972e319a379c6bab76"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of a big integer library which has been designed from the ground-up for use in cryptographic applications. Provides constant-time, no_std-friendly implementations of modern formulas using const generics."
HOMEPAGE="https://github.com/RustCrypto/crypto-bigint"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"extra-sizes"
	"rand"
	"serde"
)
