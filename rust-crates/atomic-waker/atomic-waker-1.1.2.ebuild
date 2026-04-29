# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="atomic-waker"
CRATE_VERSION="1.1.2"
CRATE_CHECKSUM="1505bd5d3d116872e7271a6d4e16d81d0c8570876c8de68093a09ac269d8aac0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A synchronization primitive for task wakeup"
HOMEPAGE="https://github.com/smol-rs/atomic-waker"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
