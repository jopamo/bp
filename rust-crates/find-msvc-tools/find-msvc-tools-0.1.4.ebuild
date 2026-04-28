# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="find-msvc-tools"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="52051878f80a721bb68ebfbc930e07b65ba72f2da88968ea5c06fd6ca3d3a127"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Find windows-specific tools, read MSVC versions from the registry and from COM interfaces"
HOMEPAGE="https://github.com/rust-lang/cc-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
