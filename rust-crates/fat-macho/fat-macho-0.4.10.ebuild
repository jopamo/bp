# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fat-macho"
CRATE_VERSION="0.4.10"
CRATE_CHECKSUM="a64465b99fa411ca36a47048e9b1deec20f609b072711e3949e6d135403ea16d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Mach-O Fat Binary Reader and Writer"
HOMEPAGE="https://github.com/messense/fat-macho-rs.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bitcode"
	"default"
)
