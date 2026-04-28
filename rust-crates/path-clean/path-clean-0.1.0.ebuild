# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="path-clean"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="ecba01bf2678719532c5e3059e0b5f0811273d94b397088b82e3bd0a78c78fdd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of cleanname or path.Clean"
HOMEPAGE="https://github.com/danreeves/path-clean"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
