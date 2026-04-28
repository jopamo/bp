# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fst"
CRATE_VERSION="0.4.7"
CRATE_CHECKSUM="7ab85b9b05e3978cc9a9cf8fea7f01b494e1a09ed3037e16ba39edc7a29eb61a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Use finite state transducers to compactly represents sets or maps of many strings (> 1 billion is possible)."
HOMEPAGE="https://github.com/BurntSushi/fst"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"levenshtein"
)
