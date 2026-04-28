# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="colorchoice"
CRATE_VERSION="1.0.4"
CRATE_CHECKSUM="b05b61dc5112cbb17e4b6cd61790d9845d13888356391624cbe7e41efeac1e75"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Global override of color control"
HOMEPAGE="https://github.com/rust-cli/anstyle.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
