# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wild"
CRATE_VERSION="2.2.1"
CRATE_CHECKSUM="a3131afc8c575281e1e80f36ed6a092aa502c08b18ed7524e86fbbb12bb410e1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Glob (wildcard) expanded command-line arguments on Windows"
HOMEPAGE="https://lib.rs/crates/wild"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"glob-quoted-on-windows"
)
