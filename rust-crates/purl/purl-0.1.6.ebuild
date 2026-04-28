# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="purl"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="60ebe4262ae91ddd28c8721111a0a6e9e58860e211fc92116c4bb85c98fd96ad"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Package URL implementation with customizable package types"
HOMEPAGE="https://github.com/phylum-dev/purl/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"package-type"
)
