# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="getopts"
CRATE_VERSION="0.2.24"
CRATE_CHECKSUM="cfe4fbac503b8d1f88e6676011885f34b7174f46e59956bba534ba83abded4df"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="getopts-like option parsing"
HOMEPAGE="https://github.com/rust-lang/getopts"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
	"unicode"
)
