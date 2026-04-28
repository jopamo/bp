# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unic-char-range"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="0398022d5f700414f6b899e10b8348231abf9173fa93144cbc1a43b9793c1fbc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UNIC — Unicode Character Tools — Character Range and Iteration"
HOMEPAGE="https://github.com/open-i18n/rust-unic/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"exact-size-is-empty"
	"fused"
	"std"
	"trusted-len"
	"unstable"
)
