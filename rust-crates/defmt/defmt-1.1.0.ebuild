# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="defmt"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="a6e524506490a1953d237cb87b1cfc1e46f88c18f10a22dfe0f507dc6bfc7f7f"
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
