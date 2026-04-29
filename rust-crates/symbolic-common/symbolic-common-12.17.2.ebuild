# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="symbolic-common"
CRATE_VERSION="12.17.2"
CRATE_CHECKSUM="751a2823d606b5d0a7616499e4130a516ebd01a44f39811be2b9600936509c23"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common types and utilities for symbolic, a library to symbolicate and process stack traces from native applications, minidumps or minified JavaScript."
HOMEPAGE="https://github.com/getsentry/symbolic"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
)
