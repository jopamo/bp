# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dlopen2_derive"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="f2b99bf03862d7f545ebc28ddd33a665b50865f4dfd84031a393823879bd4c54"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive macros for the dlopen2 crate."
HOMEPAGE="https://crates.io/crates/dlopen2_derive"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
