# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num_enum"
CRATE_VERSION="0.7.4"
CRATE_CHECKSUM="a973b4e44ce6cad84ce69d797acf9a044532e4184c4f267913d1b546a0727b7a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macros to make inter-operation between primitives and enums easier."
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
