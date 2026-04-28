# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num_enum_derive"
CRATE_VERSION="0.7.4"
CRATE_CHECKSUM="77e878c846a8abae00dd069496dbe8751b16ac1c3d6bd2a7283a938e8228f90d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Internal implementation details for ::num_enum (Procedural macros to make inter-operation between primitives and enums easier)"
HOMEPAGE="https://github.com/illicitonion/num_enum"
LICENSE="|| ( BSD-3-Clause MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"complex-expressions"
	"default"
	"external_doc"
	"std"
)
