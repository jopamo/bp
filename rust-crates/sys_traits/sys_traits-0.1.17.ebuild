# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sys_traits"
CRATE_VERSION="0.1.17"
CRATE_CHECKSUM="4f74a2c95f72e36fa6bd04a40d15623a9904bab1cc2fa6c6135b09d774a65088"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait per function for system related functionality."
HOMEPAGE="https://github.com/dsherret/sys_traits"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"filetime"
	"getrandom"
	"libc"
	"memory"
	"real"
	"serde"
	"serde_json"
	"strip_unc"
	"wasm"
	"winapi"
)
