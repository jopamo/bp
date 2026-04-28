# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sharded-slab"
CRATE_VERSION="0.1.7"
CRATE_CHECKSUM="f40ca3c46823713e0d4209592e8d6e826aa57e928f09752619fc696c499637f6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A lock-free concurrent slab."
HOMEPAGE="https://github.com/hawkw/sharded-slab"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
