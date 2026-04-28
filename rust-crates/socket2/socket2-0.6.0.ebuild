# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="socket2"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="233504af464074f9d066d7b5416c5f9b894a5862a6506e306f7b816cdd6f1807"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for handling networking sockets with a maximal amount of configuration possible intended."
HOMEPAGE="https://github.com/rust-lang/socket2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all"
)
