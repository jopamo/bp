# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pin-utils"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for pinning"
HOMEPAGE="https://github.com/rust-lang-nursery/pin-utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
