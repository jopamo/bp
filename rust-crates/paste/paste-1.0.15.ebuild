# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="paste"
CRATE_VERSION="1.0.15"
CRATE_CHECKSUM="57c0d7b74b563b49d38dae00a0c37d4d6de9b432382b2892f0574ddcae73fd0a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for all your token pasting needs"
HOMEPAGE="https://github.com/dtolnay/paste"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
