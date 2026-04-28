# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicase"
CRATE_VERSION="2.7.0"
CRATE_CHECKSUM="f7d2d4dafb69621809a81864c9c1b864479e1235c0dd4e199924b9742439ed89"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A case-insensitive wrapper around strings."
HOMEPAGE="https://github.com/seanmonstar/unicase"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
)
