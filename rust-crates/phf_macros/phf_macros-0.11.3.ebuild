# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="phf_macros"
CRATE_VERSION="0.11.3"
CRATE_CHECKSUM="f84ac04429c13a7ff43785d75ad27569f2951ce0ffd30a3321230db2fc727216"
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
