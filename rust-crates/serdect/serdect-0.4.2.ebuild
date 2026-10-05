# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serdect"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="9af4a3e75ebd5599b30d4de5768e00b5095d518a79fefc3ecbaf77e665d1ec06"
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
	"derive"
)
