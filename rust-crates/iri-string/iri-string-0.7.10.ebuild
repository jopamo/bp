# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="iri-string"
CRATE_VERSION="0.7.10"
CRATE_CHECKSUM="c91338f0783edbd6195decb37bae672fd3b165faffb89bf7b9e6942f8b1a731a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="IRI as string types"
HOMEPAGE="https://github.com/lo48576/iri-string"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
