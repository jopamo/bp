# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="clap_derive"
CRATE_VERSION="4.6.1"
CRATE_CHECKSUM="f2ce8604710f6733aa641a2b3731eaa1e8b3d9973d5e3565da11800813f997a9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parse command line argument by defining a struct, derive crate."
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"deprecated"
	"raw-deprecated"
	"unstable-markdown"
	"unstable-v5"
)
