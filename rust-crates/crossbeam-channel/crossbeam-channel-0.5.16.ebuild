# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="crossbeam-channel"
CRATE_VERSION="0.5.16"
CRATE_CHECKSUM="d85363c37faeca707aef026efa9f3b34d077bce547e48f770770625c6013679e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Multi-producer multi-consumer channels for message passing"
HOMEPAGE="https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-channel"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
