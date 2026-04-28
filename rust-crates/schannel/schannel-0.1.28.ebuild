# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="schannel"
CRATE_VERSION="0.1.28"
CRATE_CHECKSUM="891d81b926048e76efe18581bf793546b4c0eaf8448d72be8de2bbee5fd166e1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Schannel bindings for rust, allowing SSL/TLS (e.g. https) without openssl"
HOMEPAGE="https://github.com/steffengy/schannel-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
