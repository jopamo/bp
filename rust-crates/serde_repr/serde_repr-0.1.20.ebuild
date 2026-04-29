# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="serde_repr"
CRATE_VERSION="0.1.20"
CRATE_CHECKSUM="175ee3e80ae9982737ca543e96133087cbd9a485eecc3bc4de9c1a37b47ea59c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive Serialize and Deserialize that delegates to the underlying repr of a C-like enum."
HOMEPAGE="https://github.com/dtolnay/serde-repr"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
