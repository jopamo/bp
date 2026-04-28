# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="radix_fmt"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="ce082a9940a7ace2ad4a8b7d0b1eac6aa378895f18be598230c5f2284ac05426"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Format a number in an arbitrary radix"
HOMEPAGE="https://gitlab.com/Boiethios/radix_fmt_rs"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
