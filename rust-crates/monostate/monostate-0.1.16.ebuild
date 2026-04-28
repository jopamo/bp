# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="monostate"
CRATE_VERSION="0.1.16"
CRATE_CHECKSUM="5f766eeb5719df144c29802e56f3f7e0b3f29bd3ec8ab6c819aa1eaddec3f80c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Type that deserializes only from one specific value"
HOMEPAGE="https://github.com/dtolnay/monostate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
