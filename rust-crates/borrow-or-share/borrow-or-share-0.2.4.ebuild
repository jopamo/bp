# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="borrow-or-share"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="dc0b364ead1874514c8c2855ab558056ebfeb775653e7ae45ff72f28f8f3166c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for either borrowing or sharing data."
HOMEPAGE="https://github.com/yescallop/borrow-or-share"
LICENSE="MIT-0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
