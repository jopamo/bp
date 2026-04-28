# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="signal-hook-registry"
CRATE_VERSION="1.4.2"
CRATE_CHECKSUM="a9e9e0b4211b72e7b8b6e85c807d36c212bdb33ea8587f7569562a84df5465b1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Backend crate for signal-hook"
HOMEPAGE="https://github.com/vorner/signal-hook"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
