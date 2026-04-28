# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-normalization"
CRATE_VERSION="0.1.23"
CRATE_CHECKSUM="a56d1686db2308d901306f92a263857ef59ea39678a5458e7cb17f01415101f5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate provides functions for normalization of Unicode strings, including Canonical and Compatible Decomposition and Recomposition, as described in Unicode Standard Annex #15."
HOMEPAGE="https://github.com/unicode-rs/unicode-normalization"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
