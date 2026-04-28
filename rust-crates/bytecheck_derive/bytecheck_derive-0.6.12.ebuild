# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bytecheck_derive"
CRATE_VERSION="0.6.12"
CRATE_CHECKSUM="3db406d29fbcd95542e92559bed4d8ad92636d1ca8b3b72ede10b4bcc010e659"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive macro for bytecheck"
HOMEPAGE="https://github.com/djkoloski/bytecheck"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
