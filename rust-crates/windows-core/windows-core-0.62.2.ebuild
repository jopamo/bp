# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-core"
CRATE_VERSION="0.62.2"
CRATE_CHECKSUM="b8e83a14d34d0623b51dce9581199302a221863196a1dde71a7663a4c2be9deb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core type support for COM and Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
