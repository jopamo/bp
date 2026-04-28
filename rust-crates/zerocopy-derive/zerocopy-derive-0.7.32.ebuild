# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerocopy-derive"
CRATE_VERSION="0.7.32"
CRATE_CHECKSUM="9ce1b18ccd8e73a9321186f97e46f9f04b778851177567b1975109d26a08d2a6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for traits from the zerocopy crate"
HOMEPAGE="https://github.com/google/zerocopy"
LICENSE="|| ( BSD-2-Clause Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
