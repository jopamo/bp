# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="onig"
CRATE_VERSION="6.5.1"
CRATE_CHECKSUM="336b9c63443aceef14bea841b899035ae3abe89b7c486aaf4c5bd8aafedac3f0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust-Onig is a set of Rust bindings for the Oniguruma regular expression library. Oniguruma is a modern regex library with support for multiple character encodings and regex syntaxes."
HOMEPAGE="https://github.com/iwillspeak/rust-onig"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"generate"
	"posix-api"
	"print-debug"
	"std-pattern"
)
