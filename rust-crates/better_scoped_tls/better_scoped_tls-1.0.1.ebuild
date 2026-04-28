# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="better_scoped_tls"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="7cd228125315b132eed175bf47619ac79b945b26e56b848ba203ae4ea8603609"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="scoped-tls, but with good error message"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
