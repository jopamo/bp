# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="icu_normalizer_data"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="f8cafbf7aa791e9b22bec55a167906f9e1215fd475cd22adfcf660e03e989516"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data for the icu_normalizer crate"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
