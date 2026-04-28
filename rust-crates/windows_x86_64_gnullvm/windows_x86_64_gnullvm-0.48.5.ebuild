# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_x86_64_gnullvm"
CRATE_VERSION="0.48.5"
CRATE_CHECKSUM="0b7b52767868a23d5bab768e390dc5f5c55825b6d30b86c844ff2dc7414044cc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
