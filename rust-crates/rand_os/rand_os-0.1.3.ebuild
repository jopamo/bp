# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand_os"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="7b75f676a1e053fc562eafbb47838d67c84801e38fc1ba459e8f180deabd5071"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="OS backed Random Number Generator"
HOMEPAGE="https://crates.io/crates/rand_os"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
