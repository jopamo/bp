# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thread_local"
CRATE_VERSION="1.1.9"
CRATE_CHECKSUM="f60246a4944f24f6e018aa17cdeffb7818b76356965d03b07d6a9886e8962185"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Per-object thread-local storage"
HOMEPAGE="https://github.com/Amanieu/thread_local-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"nightly"
)
