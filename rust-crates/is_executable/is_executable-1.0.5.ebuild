# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="is_executable"
CRATE_VERSION="1.0.5"
CRATE_CHECKSUM="baabb8b4867b26294d818bf3f651a454b6901431711abb96e296245888d6e8c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Is there an executable file at the given path?"
HOMEPAGE="https://github.com/fitzgen/is_executable"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
