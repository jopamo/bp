# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="redox_users"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="a4e608c6638b9c18977b00b475ac1f28d14e84b27d8d42f70e0bf1e3dec127ac"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust library to access Redox users and groups functionality"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/users"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"auth"
	"default"
)
