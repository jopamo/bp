# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="phf_macros"
CRATE_VERSION="0.11.2"
CRATE_CHECKSUM="3444646e286606587e49f3bcf1679b8cef1dc2c5ecc29ddacaffc305180d464b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros to generate types in the phf crate"
HOMEPAGE="https://github.com/rust-phf/rust-phf"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"unicase"
)
