# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ecb"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="1a8bfa975b1aec2145850fcaa1c6fe269a16578c44705a532ae3edc92b8881c7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Electronic Codebook (ECB) block cipher mode of operation"
HOMEPAGE="https://github.com/magic-akari/ecb"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"block-padding"
	"default"
	"std"
)
