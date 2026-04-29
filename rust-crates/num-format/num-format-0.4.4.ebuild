# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="num-format"
CRATE_VERSION="0.4.4"
CRATE_CHECKSUM="a652d9771a63711fd3c3deb670acfbe5c30a4072e664d7a3bf5a9e1056ac72c3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust crate for producing string-representations of numbers, formatted according to international standards"
HOMEPAGE="https://github.com/bcmyers/num-format"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"with-num-bigint"
	"with-serde"
	"with-system-locale"
)
