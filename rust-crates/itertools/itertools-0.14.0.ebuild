# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="itertools"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="2b192c782037fadd9cfa75548310488aabdbf3d2da73885b31bd0abd03351285"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Extra iterator adaptors, iterator methods, free functions, and macros."
HOMEPAGE="https://github.com/rust-itertools/itertools"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_alloc"
	"use_std"
)
