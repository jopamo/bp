# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strum_macros"
CRATE_VERSION="0.28.0"
CRATE_CHECKSUM="ab85eea0270ee17587ed4156089e10b9e6880ee688791d45a905f5b1ca36f664"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helpful macros for working with enums and strings"
HOMEPAGE="https://github.com/Peternator7/strum"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
