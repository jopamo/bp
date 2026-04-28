# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="either"
CRATE_VERSION="1.10.0"
CRATE_CHECKSUM="11157ac094ffbdde99aa67b23417ebdd801842852b500e395a45a9c0aac03e4a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The enum `Either` with variants `Left` and `Right` is a general purpose sum type with two cases."
HOMEPAGE="https://github.com/rayon-rs/either"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_std"
)
