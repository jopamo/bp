# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_derive_internals"
CRATE_VERSION="0.29.1"
CRATE_CHECKSUM="18d26a20a969b9e3fdf2fc2d9f21eda6c40e2de84c9408bb5d3b05d499aae711"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="AST representation used by Serde derive macros. Unstable."
HOMEPAGE="https://serde.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
