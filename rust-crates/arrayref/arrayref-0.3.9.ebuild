# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="arrayref"
CRATE_VERSION="0.3.9"
CRATE_CHECKSUM="76a2e8124351fda1ef8aaaa3bbd7ebbcb486bbcd4225aca0aa0d84bb2db8fecb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros to take array references of slices"
HOMEPAGE="https://github.com/droundy/arrayref"
LICENSE="BSD-2-Clause"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
