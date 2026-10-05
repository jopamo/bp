# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="password-hash"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="aab41826031698d6ffcd9cff78ef56ef998e39dc7e5067cdfebe373842d4723b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits which describe the functionality of password hashing algorithms, with optional support for a \`no_std\`/\`no_alloc\`-friendly implementation of the PHC string format, as well as generic support for other formats (e.g. Modular Crypt Format)"
HOMEPAGE="https://github.com/RustCrypto/traits"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"getrandom"
	"rand_core"
)
