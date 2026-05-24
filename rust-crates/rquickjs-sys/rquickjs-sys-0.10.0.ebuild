# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rquickjs-sys"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="57b1b6528590d4d65dc86b5159eae2d0219709546644c66408b2441696d1d725"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="QuickJS bindings for rquickjs"
HOMEPAGE="https://github.com/DelSkayn/rquickjs.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bindgen"
	"disable-assertions"
	"dump-atoms"
	"dump-bytecode"
	"dump-free"
	"dump-gc"
	"dump-gc-free"
	"dump-leaks"
	"dump-mem"
	"dump-module-resolve"
	"dump-objects"
	"dump-promise"
	"dump-read-object"
	"dump-shapes"
	"logging"
	"update-bindings"
)
