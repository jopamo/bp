# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="khronos_api"
CRATE_VERSION="3.1.0"
CRATE_CHECKSUM="e2db585e1d738fc771bf08a151420d3ed193d9d895a36df7f6f8a9456b911ddc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The Khronos XML API Registry, exposed as byte string constants."
HOMEPAGE="https://github.com/brendanzab/gl-rs/"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
