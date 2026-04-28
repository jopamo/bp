# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="glutin_egl_sys"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="4c4680ba6195f424febdc3ba46e7a42a0e58743f2edb115297b86d7f8ecc02d2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The egl bindings for glutin"
HOMEPAGE="https://github.com/rust-windowing/glutin"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
