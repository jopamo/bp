# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="win32job"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="5b2b1bf557d947847a30eb73f79aa6cdb3eaf3ce02f5e9599438f77896a62b3c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A safe API for Windows' job objects."
HOMEPAGE="https://github.com/ohadravid/win32job-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
