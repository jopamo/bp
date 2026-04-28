# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="password-hash"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="346f04948ba92c43e8469c1ee6736c7563d71012b17d40745260fe106aac2166"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits which describe the functionality of password hashing algorithms, as well as a \`no_std\`-friendly implementation of the PHC string format (a well-defined subset of the Modular Crypt Format a.k.a. MCF)"
HOMEPAGE="https://github.com/RustCrypto/traits/tree/master/password-hash"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"getrandom"
	"std"
)
