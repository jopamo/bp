# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_v8"
CRATE_VERSION="0.272.0"
CRATE_CHECKSUM="32427bd456d2b201a569106be8590a3bd149ba3c9ef1656998a4a1dcf08a0812"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust to V8 serialization and deserialization"
HOMEPAGE="https://github.com/denoland/deno_core"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
