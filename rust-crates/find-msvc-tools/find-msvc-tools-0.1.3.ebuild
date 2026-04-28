# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="find-msvc-tools"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="0399f9d26e5191ce32c498bebd31e7a3ceabc2745f0ac54af3f335126c3f24b3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Find windows-specific tools, read MSVC versions from the registry and from COM interfaces"
HOMEPAGE="https://github.com/rust-lang/cc-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
