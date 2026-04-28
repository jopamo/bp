# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="itertools"
CRATE_VERSION="0.12.1"
CRATE_CHECKSUM="ba291022dbbd398a455acf126c1e341954079855bc60dfdda641363bd6922569"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Extra iterator adaptors, iterator methods, free functions, and macros."
HOMEPAGE="https://github.com/rust-itertools/itertools"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_alloc"
	"use_std"
)
