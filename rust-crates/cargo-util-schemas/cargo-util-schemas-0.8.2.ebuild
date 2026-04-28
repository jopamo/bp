# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo-util-schemas"
CRATE_VERSION="0.8.2"
CRATE_CHECKSUM="7dc1a6f7b5651af85774ae5a34b4e8be397d9cf4bc063b7e6dbd99a841837830"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Deserialization schemas for Cargo"
HOMEPAGE="https://github.com/rust-lang/cargo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"unstable-schema"
)
