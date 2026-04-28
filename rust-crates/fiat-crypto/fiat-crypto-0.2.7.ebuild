# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fiat-crypto"
CRATE_VERSION="0.2.7"
CRATE_CHECKSUM="c007b1ae3abe1cb6f85a16305acd418b7ca6343b953633fee2b76d8f108b830f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fiat-crypto generated Rust"
HOMEPAGE="https://github.com/mit-plv/fiat-crypto"
LICENSE="|| ( MIT Apache-2.0 BSD-1-Clause )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
