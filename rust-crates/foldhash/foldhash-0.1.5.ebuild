# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="foldhash"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="d9c4f5dac5e15c24eb999c26181a6ca40b39fe946cbe4c263c7209467bc83af2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast, non-cryptographic, minimally DoS-resistant hashing algorithm."
HOMEPAGE="https://github.com/orlp/foldhash"
LICENSE="Zlib"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
