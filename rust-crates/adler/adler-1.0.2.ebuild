# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="adler"
CRATE_VERSION="1.0.2"
CRATE_CHECKSUM="f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple clean-room implementation of the Adler-32 checksum"
HOMEPAGE="https://github.com/jonas-schievink/adler.git"
LICENSE="|| ( 0BSD MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
	"std"
)
