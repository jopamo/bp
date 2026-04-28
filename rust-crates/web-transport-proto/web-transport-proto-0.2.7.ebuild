# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="web-transport-proto"
CRATE_VERSION="0.2.7"
CRATE_CHECKSUM="fb650c577c46254d16041c7fe0dc9901d9a42df3f46e77e9d05d1b3c17294b19"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WebTransport core protocol"
HOMEPAGE="https://github.com/kixelated/web-transport"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
