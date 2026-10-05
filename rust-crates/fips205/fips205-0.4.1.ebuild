# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fips205"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="2f5626bf5534df4ebdbd2536465d7eaa8a9dc2cdeb7e036e0ecf291dcc80ffb6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FIPS 205: Stateless Hash-Based Digital Signature Standard"
HOMEPAGE="https://github.com/integritychain/fips205"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"default-rng"
	"slh_dsa_sha2_128f"
	"slh_dsa_sha2_128s"
	"slh_dsa_sha2_192f"
	"slh_dsa_sha2_192s"
	"slh_dsa_sha2_256f"
	"slh_dsa_sha2_256s"
	"slh_dsa_shake_128f"
	"slh_dsa_shake_128s"
	"slh_dsa_shake_192f"
	"slh_dsa_shake_192s"
	"slh_dsa_shake_256f"
	"slh_dsa_shake_256s"
)
