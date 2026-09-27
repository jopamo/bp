# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="defmt"
CRATE_VERSION="1.1.1"
CRATE_CHECKSUM="e2953bfe4f93bbd20cc71198842756f77d161884c99ebbabc41d80231ded88d1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A highly efficient logging framework that targets resource-constrained devices, like microcontrollers"
HOMEPAGE="https://knurling.ferrous-systems.com/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"avoid-default-panic"
	"encoding-raw"
	"encoding-rzcobs"
	"ip_in_core"
	"unstable-test"
)
