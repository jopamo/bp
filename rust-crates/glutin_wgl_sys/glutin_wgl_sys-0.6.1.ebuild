# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="glutin_wgl_sys"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="2c4ee00b289aba7a9e5306d57c2d05499b2e5dc427f84ac708bd2c090212cf3e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The wgl bindings for glutin"
HOMEPAGE="https://github.com/rust-windowing/glutin"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
