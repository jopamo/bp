# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="os_pipe"
CRATE_VERSION="1.2.3"
CRATE_CHECKSUM="7d8fae84b431384b68627d0f9b3b1245fcf9f46f6c0e3dc902e9dce64edd1967"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="a cross-platform library for opening OS pipes"
HOMEPAGE="https://github.com/oconnor663/os_pipe.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"io_safety"
)
