# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="regalloc2"
CRATE_VERSION="0.11.1"
CRATE_CHECKSUM="145c1c267e14f20fb0f88aa76a1c5ffec42d592c1d28b3cd9148ae35916158d3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Backtracking register allocator inspired from IonMonkey"
HOMEPAGE="https://github.com/bytecodealliance/regalloc2"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"checker"
	"default"
	"enable-serde"
	"fuzzing"
	"std"
	"trace-log"
)
