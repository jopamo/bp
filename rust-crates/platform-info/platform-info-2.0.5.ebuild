# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="platform-info"
CRATE_VERSION="2.0.5"
CRATE_CHECKSUM="7539aeb3fdd8cb4f6a331307cf71a1039cee75e94e8a71725b9484f4a0d9451a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple cross-platform interface to get info about a system"
HOMEPAGE="https://github.com/uutils/platform-info"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
