# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="dtor-proc-macro"
CRATE_VERSION="0.0.6"
CRATE_CHECKSUM="f678cf4a922c215c63e0de95eb1ff08a958a81d47e485cf9da1e27bf6305cfa5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="proc-macro support for the dtor crate"
HOMEPAGE="https://github.com/mmastrac/rust-ctor"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
