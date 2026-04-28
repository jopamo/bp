# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-id-start"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="bc3882f69607a2ac8cc4de3ee7993d8f68bb06f2974271195065b3bd07f2edea"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine whether characters have the ID_Start or ID_Continue properties according to Unicode Standard Annex #31"
HOMEPAGE="https://github.com/Boshen/unicode-id-start"
LICENSE="|| ( MIT Apache-2.0 ) Unicode-DFS-2016"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
