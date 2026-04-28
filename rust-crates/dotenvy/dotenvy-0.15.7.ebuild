# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dotenvy"
CRATE_VERSION="0.15.7"
CRATE_CHECKSUM="1aaf95b3e5c8f23aa320147307562d361db0ae0d51242340f558153b4eb2439b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A well-maintained fork of the dotenv crate"
HOMEPAGE="https://github.com/allan2/dotenvy"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cli"
)
