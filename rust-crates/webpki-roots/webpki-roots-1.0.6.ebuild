# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="webpki-roots"
CRATE_VERSION="1.0.6"
CRATE_CHECKSUM="22cfaf3c063993ff62e73cb4311efde4db1efb31ab78a3e5c457939ad5cc0bed"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Mozilla's CA root certificates for use with webpki"
HOMEPAGE="https://github.com/rustls/webpki-roots"
LICENSE="CDLA-Permissive-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
