# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="same-file"
CRATE_VERSION="1.0.6"
CRATE_CHECKSUM="93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple crate for determining whether two file paths point to the same file."
HOMEPAGE="https://github.com/BurntSushi/same-file"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
