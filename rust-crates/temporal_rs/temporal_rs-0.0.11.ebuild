# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="temporal_rs"
CRATE_VERSION="0.0.11"
CRATE_CHECKSUM="7807e330b12e288b847a3e2a2b0dcd41ca764d0f90f9e8940f02c6ddd68cd2d7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Temporal in Rust is an implementation of the TC39 Temporal Builtin Proposal in Rust."
HOMEPAGE="https://github.com/boa-dev/temporal"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compiled_data"
	"default"
	"log"
	"std"
	"sys"
	"tzdb"
)
