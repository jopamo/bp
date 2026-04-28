# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tokio-socks"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="51165dfa029d2a65969413a6cc96f354b86b464498702f174a4efa13608fd8c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Asynchronous SOCKS proxy support for Rust."
HOMEPAGE="https://github.com/sticnarf/tokio-socks"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"tor"
)
