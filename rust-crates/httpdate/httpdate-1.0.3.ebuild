# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="httpdate"
CRATE_VERSION="1.0.3"
CRATE_CHECKSUM="df3b46402a9d5adb4c86a0cf463f42e19994e3ee891101b1841f30a545cb49a9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="HTTP date parsing and formatting"
HOMEPAGE="https://github.com/pyfisch/httpdate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
