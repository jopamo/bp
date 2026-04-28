# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="is-macro"
CRATE_VERSION="0.3.5"
CRATE_CHECKSUM="59a85abdc13717906baccb5a1e435556ce0df215f242892f721dff62bf25288f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive methods for using custom enums like Option / Result"
HOMEPAGE="https://github.com/dudykr/ddbase"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
