# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="raffia_macro"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="4fdb50eb5bf734fa5a770680a61876a6ec77b99c1e0e52d1f18ad6ebfa85759f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for Raffia."
HOMEPAGE="https://github.com/g-plane/raffia"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
