# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="security-framework-sys"
CRATE_VERSION="2.14.0"
CRATE_CHECKSUM="49db231d56a190491cb4aeda9527f1ad45345af50b0851622a7adb8c03b01c32"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Apple `Security.framework` low-level FFI bindings"
HOMEPAGE="https://lib.rs/crates/security-framework-sys"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"OSX_10_10"
	"OSX_10_11"
	"OSX_10_12"
	"OSX_10_13"
	"OSX_10_14"
	"OSX_10_15"
	"OSX_10_9"
	"default"
)
