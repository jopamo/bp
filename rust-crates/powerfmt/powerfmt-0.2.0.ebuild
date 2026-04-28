# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="powerfmt"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="`powerfmt` is a library that provides utilities for formatting values. This crate makes it significantly easier to support filling to a minimum width with alignment, avoid heap allocation, and avoid repetitive calculations."
HOMEPAGE="https://github.com/jhpratt/powerfmt"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"macros"
	"std"
)
