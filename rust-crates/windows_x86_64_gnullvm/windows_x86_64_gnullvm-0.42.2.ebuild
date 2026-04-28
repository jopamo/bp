# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_x86_64_gnullvm"
CRATE_VERSION="0.42.2"
CRATE_CHECKSUM="26d41b46a36d453748aedef1486d5c7a85db22e56aff34643984ea85514e94a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
