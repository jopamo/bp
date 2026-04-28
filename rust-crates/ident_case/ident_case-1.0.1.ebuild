# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ident_case"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="b9e0384b61958566e926dc50660321d12159025e767c18e043daf26b70104c39"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utility for applying case rules to Rust identifiers."
HOMEPAGE="https://github.com/TedDriggs/ident_case"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
