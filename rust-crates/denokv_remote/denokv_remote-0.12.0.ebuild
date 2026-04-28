# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="denokv_remote"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="91a6b359d69cb44e4390f2bcd007f72c252c6b9f6f88c7eab8f9bb55806fbc1a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Remote (KV Connect) backend for Deno KV"
HOMEPAGE="https://github.com/denoland/denokv"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
