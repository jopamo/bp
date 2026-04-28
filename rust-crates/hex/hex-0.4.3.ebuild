# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hex"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5fd8f86ba55232a70"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Encoding and decoding data into/from hexadecimal representation."
HOMEPAGE="https://github.com/KokaKiwi/rust-hex"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
