# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ecow"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="e42fc0a93992b20c58b99e59d61eaf1635a25bfbe49e4275c34ba0aee98119ba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Compact, clone-on-write vector and string."
HOMEPAGE="https://github.com/typst/ecow"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
