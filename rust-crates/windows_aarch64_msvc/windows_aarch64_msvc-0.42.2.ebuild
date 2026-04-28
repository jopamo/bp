# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_aarch64_msvc"
CRATE_VERSION="0.42.2"
CRATE_CHECKSUM="e08e8864a60f06ef0d0ff4ba04124db8b0fb3be5776a5cd47641e942e58c4d43"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
