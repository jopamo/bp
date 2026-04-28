# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="inotify-sys"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="e05c02b5e89bff3b946cedeca278abc628fe811e604f027c45a8aa3cf793d0eb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="inotify bindings for the Rust programming language"
HOMEPAGE="https://github.com/hannobraun/inotify-sys"
LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
