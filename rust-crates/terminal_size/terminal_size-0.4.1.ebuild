# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="terminal_size"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="5352447f921fda68cf61b4101566c0bdb5104eff6804d0678e5227580ab6a4e9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Gets the size of your Linux or Windows terminal"
HOMEPAGE="https://github.com/eminence/terminal-size"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
