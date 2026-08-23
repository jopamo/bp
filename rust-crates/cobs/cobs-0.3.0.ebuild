# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cobs"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="0fa961b519f0b462e3a3b4a34b64d119eeaca1d59af726fe450bbba07a9fc0a1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This is an implementation of the Consistent Overhead Byte Stuffing (COBS) algorithm. COBS is an algorithm for transforming a message into an encoding where a specific value (the \"sentinel\" value) is not used. This value can then be used to mark frame boundaries in a serial communication channel."
HOMEPAGE="https://github.com/jamesmunns/cobs.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
	"use_std"
)
