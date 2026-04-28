# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstyle-query"
CRATE_VERSION="1.1.5"
CRATE_CHECKSUM="40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Look up colored console capabilities"
HOMEPAGE="https://github.com/rust-cli/anstyle.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
