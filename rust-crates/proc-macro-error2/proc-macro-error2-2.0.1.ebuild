# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="proc-macro-error2"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="11ec05c52be0a07b08061f7dd003e7d7092e0472bc731b4af7bb1ef876109802"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Almost drop-in replacement to panics in proc-macros"
HOMEPAGE="https://github.com/GnomedDev/proc-macro-error-2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"syn-error"
)
