# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dissimilar"
CRATE_VERSION="1.0.9"
CRATE_CHECKSUM="59f8e79d1fbf76bdfbde321e902714bf6c49df88a7dda6fc682fc2979226962d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Diff library with semantic cleanup, based on Google's diff-match-patch"
HOMEPAGE="https://github.com/dtolnay/dissimilar"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
