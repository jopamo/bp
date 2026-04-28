# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="schemars_derive"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="7d115b50f4aaeea07e79c1912f645c7513d81715d0420f8bc77a18c6260b307f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for #[derive(JsonSchema)], for use with schemars"
HOMEPAGE="https://graham.cool/schemars/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
