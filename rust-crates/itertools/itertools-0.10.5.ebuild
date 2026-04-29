# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="itertools"
CRATE_VERSION="0.10.5"
CRATE_CHECKSUM="b0fd2260e829bddf4cb6ea802289de2f86d6a7a690192fbe91b3f46e0f2c8473"
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
