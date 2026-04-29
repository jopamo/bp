# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="winapi-util"
CRATE_VERSION="0.1.9"
CRATE_CHECKSUM="cf221c93e13a30d793f7645a0e7762c55d169dbb0a49671918a2319d289b10bb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A dumping ground for high level safe wrappers over windows-sys."
HOMEPAGE="https://github.com/BurntSushi/winapi-util"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
