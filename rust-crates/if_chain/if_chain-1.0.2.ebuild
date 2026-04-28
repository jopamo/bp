# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="if_chain"
CRATE_VERSION="1.0.2"
CRATE_CHECKSUM="cb56e1aa765b4b4f3aadfab769793b7087bb03a4ea4920644a6d238e2df5b9ed"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for writing nested `if let` expressions."
HOMEPAGE="https://github.com/lambda-fairy/if_chain"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
