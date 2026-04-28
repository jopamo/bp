# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="linux-keyutils"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="761e49ec5fd8a5a463f9b84e877c373d888935b71c6be78f3767fe2ae6bed18e"
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
