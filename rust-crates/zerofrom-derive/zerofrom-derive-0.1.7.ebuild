# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zerofrom-derive"
CRATE_VERSION="0.1.7"
CRATE_CHECKSUM="11532158c46691caf0f2593ea8358fed6bbf68a0315e80aae9bd41fbade684a1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for the zerofrom crate"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
