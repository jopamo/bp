# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sha1_smol"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="ae1a47186c03a32177042e55dbc5fd5aee900b8e0069a8d70fba96a9375cd012"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Minimal dependency free implementation of SHA1 for Rust."
HOMEPAGE="https://github.com/mitsuhiko/sha1-smol"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
