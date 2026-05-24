# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rquickjs-macro"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="89f93602cc3112c7f30bf5f29e722784232138692c7df4c52ebbac7e035d900d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macros for rquickjs"
HOMEPAGE="https://github.com/DelSkayn/rquickjs.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bindgen"
	"phf"
)
