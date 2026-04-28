# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="md4"
CRATE_VERSION="0.10.2"
CRATE_CHECKSUM="7da5ac363534dce5fabf69949225e174fbf111a498bf0ff794c8ea1fba9f3dda"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="MD4 hash function"
HOMEPAGE="https://github.com/RustCrypto/hashes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"oid"
	"std"
)
