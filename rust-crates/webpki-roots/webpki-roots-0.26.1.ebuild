# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="webpki-roots"
CRATE_VERSION="0.26.1"
CRATE_CHECKSUM="b3de34ae270483955a94f4b21bdaaeb83d508bb84a01435f393818edb0012009"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Mozilla's CA root certificates for use with webpki"
HOMEPAGE="https://github.com/rustls/webpki-roots"
LICENSE="MPL-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
