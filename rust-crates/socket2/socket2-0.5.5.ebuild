# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="socket2"
CRATE_VERSION="0.5.5"
CRATE_CHECKSUM="7b5fac59a5cb5dd637972e5fca70daf0523c9067fcdc4842f053dae04a18f8e9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for handling networking sockets with a maximal amount of configuration possible intended."
HOMEPAGE="https://github.com/rust-lang/socket2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"all"
)
