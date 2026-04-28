# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra-ap-rustc_lexer"
CRATE_VERSION="0.123.0"
CRATE_CHECKSUM="2b734cfcb577d09877799a22742f1bd398be6c00bc428d9de56d48d11ece5771"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically published version of the package `rustc_lexer` in the rust-lang/rust repository from commit 052114f0c5e8d49f62f8caba364b07017310ab09 The publishing script for this crate lives at: https://github.com/rust-analyzer/rustc-auto-publish"
HOMEPAGE="https://github.com/rust-lang/rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
