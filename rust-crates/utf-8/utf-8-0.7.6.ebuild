# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="utf-8"
CRATE_VERSION="0.7.6"
CRATE_CHECKSUM="09cc8ee72d2a9becf2f2febe0205bbed8fc6615b7cb429ad062dc7b7ddd036a9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Incremental, zero-copy UTF-8 decoding with error handling"
HOMEPAGE="https://github.com/SimonSapin/rust-utf8"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
