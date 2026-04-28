# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="redox_users"
CRATE_VERSION="0.4.5"
CRATE_CHECKSUM="bd283d9651eeda4b2a83a43c1c91b266c40fd76ecd39a50a8c630ae69dc72891"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust library to access Redox users and groups functionality"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/users"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"auth"
	"default"
)
