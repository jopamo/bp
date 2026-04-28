# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="itertools"
CRATE_VERSION="0.13.0"
CRATE_CHECKSUM="413ee7dfc52ee1a4949ceeb7dbc8a33f2d6c088194d9f922fb8318faf1f01186"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Extra iterator adaptors, iterator methods, free functions, and macros."
HOMEPAGE="https://github.com/rust-itertools/itertools"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_alloc"
	"use_std"
)
