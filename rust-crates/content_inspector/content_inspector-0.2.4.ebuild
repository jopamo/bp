# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="content_inspector"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="b7bda66e858c683005a53a9a60c69a4aca7eeaa45d124526e389f7aec8e62f38"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast inspection of binary buffers to guess/determine the encoding"
HOMEPAGE="https://github.com/sharkdp/content_inspector"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
