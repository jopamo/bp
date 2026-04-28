# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="backtrace"
CRATE_VERSION="0.3.74"
CRATE_CHECKSUM="8d82cb332cdfaed17ae235a638438ac4d4839913cc2af585c3c6746e8f8bee1a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to acquire a stack trace (backtrace) at runtime in a Rust program."
HOMEPAGE="https://github.com/rust-lang/backtrace-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"coresymbolication"
	"dbghelp"
	"default"
	"dl_iterate_phdr"
	"dladdr"
	"kernel32"
	"libunwind"
	"serialize-serde"
	"std"
	"unix-backtrace"
)
