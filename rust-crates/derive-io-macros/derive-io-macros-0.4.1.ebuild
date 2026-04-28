# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="derive-io-macros"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="8d0a1bd7eeab72097740967d03d53db5fbaf8e3c0dd471ebdefa43ce445a20a6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Support macros for derive-io"
HOMEPAGE="https://github.com/mmastrac/derive-io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
