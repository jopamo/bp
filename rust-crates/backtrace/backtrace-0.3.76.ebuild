# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="backtrace"
CRATE_VERSION="0.3.76"
CRATE_CHECKSUM="bb531853791a215d7c62a30daf0dde835f381ab5de4589cfe7c649d2cbe92bd6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to acquire a stack trace (backtrace) at runtime in a Rust program."
HOMEPAGE="https://github.com/rust-lang/backtrace-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"coresymbolication"
	"dbghelp"
	"default"
	"dl_iterate_phdr"
	"dladdr"
	"kernel32"
	"libunwind"
	"ruzstd"
	"serialize-serde"
	"std"
	"unix-backtrace"
)
