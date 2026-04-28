# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winapi-util"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="f29e6f9198ba0d26b4c9f07dbe6f9ed633e1f3d5b8b414090084349e46a52596"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A dumping ground for high level safe wrappers over winapi."
HOMEPAGE="https://github.com/BurntSushi/winapi-util"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
