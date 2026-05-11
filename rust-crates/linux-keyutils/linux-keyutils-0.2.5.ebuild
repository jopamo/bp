# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="linux-keyutils"
CRATE_VERSION="0.2.5"
CRATE_CHECKSUM="83270a18e9f90d0707c41e9f35efada77b64c0e6f3f1810e71c8368a864d5590"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust interface to the Linux key-management facility. Provides a safe interface around the raw system calls allowing user-space programs to perform key manipulation."
HOMEPAGE="https://github.com/landhb/linux-keyutils"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
