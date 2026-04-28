# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="backtrace"
CRATE_VERSION="0.3.75"
CRATE_CHECKSUM="6806a6321ec58106fea15becdad98371e28d92ccbc7c8f1b3b6dd724fe8f1002"
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
