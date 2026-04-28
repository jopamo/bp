# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="encoding-index-korean"
CRATE_VERSION="1.20141219.5"
CRATE_CHECKSUM="4dc33fb8e6bcba213fe2f14275f0963fd16f0a02c878e3095ecfdf5bee529d81"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Index tables for Korean character encodings"
HOMEPAGE="https://github.com/lifthrasiir/rust-encoding"
LICENSE="CC0-1.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
