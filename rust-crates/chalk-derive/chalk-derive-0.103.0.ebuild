# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="chalk-derive"
CRATE_VERSION="0.103.0"
CRATE_CHECKSUM="eb4899682de915ca7c0b025bdd0a3d34c75fe12184122fda6805a7baddaa293c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A helper crate for use by chalk crates for \`derive\` macros."
HOMEPAGE="https://github.com/rust-lang/chalk"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
