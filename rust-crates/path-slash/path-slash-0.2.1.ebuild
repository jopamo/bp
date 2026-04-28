# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="path-slash"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="1e91099d4268b0e11973f036e885d652fb0b21fedcf69738c627f94db6a44f42"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Conversion to/from a file path from/to slash path"
HOMEPAGE="https://github.com/rhysd/path-slash"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
