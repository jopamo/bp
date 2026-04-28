# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ref-cast-impl"
CRATE_VERSION="1.0.24"
CRATE_CHECKSUM="1165225c21bff1f3bbce98f5a1f889949bc902d3575308cc7b0de30b4f6d27c7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive implementation for ref_cast::RefCast."
HOMEPAGE="https://github.com/dtolnay/ref-cast"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
