# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="endian-type"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="c34f04666d835ff5d62e058c3995147c06f42fe86ff053337632bca83e42702d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Type safe wrappers for types with a defined byte order"
HOMEPAGE="https://github.com/Lolirofle/endian-type"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
