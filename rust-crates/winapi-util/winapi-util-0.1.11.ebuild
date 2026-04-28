# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winapi-util"
CRATE_VERSION="0.1.11"
CRATE_CHECKSUM="c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A dumping ground for high level safe wrappers over windows-sys."
HOMEPAGE="https://github.com/BurntSushi/winapi-util"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
