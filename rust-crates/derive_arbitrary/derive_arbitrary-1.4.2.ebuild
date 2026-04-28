# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="derive_arbitrary"
CRATE_VERSION="1.4.2"
CRATE_CHECKSUM="1e567bd82dcff979e4b03460c307b3cdc9e96fde3d73bed1496d2bc75d9dd62a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derives arbitrary traits"
HOMEPAGE="https://github.com/rust-fuzz/arbitrary"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
