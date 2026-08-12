# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="shlex"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="f8fadd59c855ef2080decdef8ff161eb6661b86933c9d82e5ba29dc602a55aba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Split a string into shell words, like Python's shlex."
HOMEPAGE="https://github.com/comex/rust-shlex"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
