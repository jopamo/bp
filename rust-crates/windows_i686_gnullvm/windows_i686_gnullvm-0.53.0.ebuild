# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows_i686_gnullvm"
CRATE_VERSION="0.53.0"
CRATE_CHECKSUM="9ce6ccbdedbf6d6354471319e781c0dfef054c81fbc7cf83f338a4296c0cae11"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import lib for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
