# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-numerics"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="6e2e40844ac143cdb44aead537bbf727de9b044e107a0f1220392177d15b0f26"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Windows numeric types"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
