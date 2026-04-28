# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="encode_unicode"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="34aa73646ffb006b8f5147f3dc182bd4bcb190227ce861fc4a4844bf8e3cb2c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UTF-8 and UTF-16 character types, iterators and related methods for char, u8 and u16."
HOMEPAGE="https://github.com/tormol/encode_unicode"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
