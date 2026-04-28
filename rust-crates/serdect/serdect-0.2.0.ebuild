# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serdect"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="a84f14a19e9a014bb9f4512488d9829a68e04ecabffb0f9904cd1ace94598177"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Constant-time serde serializer/deserializer helpers for data that potentially contains secrets (e.g. cryptographic keys)"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/serdect"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
)
