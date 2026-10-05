# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="sys_traits"
CRATE_VERSION="0.1.28"
CRATE_CHECKSUM="88826d6169418c98e8bc52a43f79d50907dfa3e87ba5161930d42c6f980b35ee"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait per function for system related functionality."
HOMEPAGE="https://github.com/dsherret/sys_traits"
LICENSE="MIT"
SLOT="${PV}"
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
