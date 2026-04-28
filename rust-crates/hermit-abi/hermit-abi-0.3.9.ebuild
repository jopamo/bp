# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hermit-abi"
CRATE_VERSION="0.3.9"
CRATE_CHECKSUM="d231dfb89cfffdbc30e7fc41579ed6066ad03abda9e567ccafae602b97ec5024"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Hermit system calls definitions."
HOMEPAGE="https://github.com/hermit-os/hermit-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
)
