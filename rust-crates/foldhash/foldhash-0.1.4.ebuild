# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="foldhash"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="a0d2fde1f7b3d48b8395d5f2de76c18a528bd6a9cdde438df747bfcba3e05d6f"
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
