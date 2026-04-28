# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="os_pipe"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="5ffd2b0a5634335b135d5728d84c5e0fd726954b87111f7506a61c502280d982"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="a cross-platform library for opening OS pipes"
HOMEPAGE="https://github.com/oconnor663/os_pipe.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"io_safety"
)
