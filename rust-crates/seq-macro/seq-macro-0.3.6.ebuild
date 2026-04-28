# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="seq-macro"
CRATE_VERSION="0.3.6"
CRATE_CHECKSUM="1bc711410fbe7399f390ca1c3b60ad0f53f80e95c5eb935e52268a0e2cd49acc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro to repeat sequentially indexed copies of a fragment of code."
HOMEPAGE="https://github.com/dtolnay/seq-macro"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
