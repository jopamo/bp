# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fsevent-sys"
CRATE_VERSION="4.1.0"
CRATE_CHECKSUM="76ee7a02da4d231650c7cea31349b889be2f45ddb3ef3032d2ec8185f6313fd2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings to the fsevent macOS API for file changes notifications"
HOMEPAGE="https://github.com/octplane/fsevent-rust/tree/master/fsevent-sys"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
