# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="seahash"
CRATE_VERSION="4.1.0"
CRATE_CHECKSUM="1c107b6f4780854c8b126e228ea8869f4d7b71260f962fefb57b996b8959ba6b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A blazingly fast, portable hash function with proven statistical guarantees."
HOMEPAGE="https://gitlab.redox-os.org/redox-os/seahash"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_std"
)
