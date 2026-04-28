# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="auto_impl"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="3c87f3f15e7794432337fc718554eaa4dc8f04c9677a950ffe366f20a162ae42"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically implement traits for common smart pointers and closures"
HOMEPAGE="https://github.com/auto-impl-rs/auto_impl/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
