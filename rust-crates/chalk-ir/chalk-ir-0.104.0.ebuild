# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="chalk-ir"
CRATE_VERSION="0.104.0"
CRATE_CHECKSUM="7047a516de16226cd17344d41a319d0ea1064bf9e60bd612ab341ab4a34bbfa8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Chalk's internal representation of types, goals, and clauses"
HOMEPAGE="https://github.com/rust-lang/chalk"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
