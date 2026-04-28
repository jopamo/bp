# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dissimilar"
CRATE_VERSION="1.0.10"
CRATE_CHECKSUM="8975ffdaa0ef3661bfe02dbdcc06c9f829dfafe6a3c474de366a8d5e44276921"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Diff library with semantic cleanup, based on Google's diff-match-patch"
HOMEPAGE="https://github.com/dtolnay/dissimilar"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
