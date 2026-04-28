# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="smol_str"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="9676b89cd56310a87b93dec47b11af744f34d5fc9f367b829474eec0a891350d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="small-string optimized string type with O(1) clone"
HOMEPAGE="https://github.com/rust-analyzer/smol_str"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
