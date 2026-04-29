# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="pem"
CRATE_VERSION="3.0.6"
CRATE_CHECKSUM="1d30c53c26bc5b31a98cd02d20f25a7c8567146caf63ed593a9d87b2775291be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parse and encode PEM-encoded data."
HOMEPAGE="https://github.com/jcreekmore/pem-rs.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"std"
)
