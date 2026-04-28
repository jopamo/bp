# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="glob"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Support for matching file paths against Unix shell style patterns."
HOMEPAGE="https://github.com/rust-lang/glob"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
