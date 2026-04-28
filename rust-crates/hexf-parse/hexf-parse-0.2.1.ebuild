# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hexf-parse"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="dfa686283ad6dd069f105e5ab091b04c62850d3e4cf5d67debad1933f55023df"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parses hexadecimal floats (see also hexf)"
HOMEPAGE="https://github.com/lifthrasiir/hexf"
LICENSE="CC0-1.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
