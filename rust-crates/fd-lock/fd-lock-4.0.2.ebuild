# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fd-lock"
CRATE_VERSION="4.0.2"
CRATE_CHECKSUM="7e5768da2206272c81ef0b5e951a41862938a6070da63bcea197899942d3b947"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Advisory cross-platform lock on a file using a file descriptor to it."
HOMEPAGE="https://github.com/yoshuawuyts/fd-lock"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
