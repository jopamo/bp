# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="oneshot"
CRATE_VERSION="0.1.13"
CRATE_CHECKSUM="269bca4c2591a28585d6bf10d9ed0332b7d76900a1b02bec41bdc3a2cdcda107"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Oneshot spsc channel with (potentially) lock-free non-blocking send, and a receiver supporting both thread blocking receive operations as well as Future based async polling."
HOMEPAGE="https://github.com/faern/oneshot"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async"
	"default"
	"std"
)
