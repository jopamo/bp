# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="onig_sys"
CRATE_VERSION="69.9.1"
CRATE_CHECKSUM="c7f86c6eef3d6df15f23bcfb6af487cbd2fed4e5581d58d5bf1f5f8b7f6727dc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The \`onig_sys\` crate contains raw rust bindings to the oniguruma library. This crate exposes a set of unsafe functions which can then be used by other crates to create safe wrappers around Oniguruma. You probably don't want to link to this crate directly; instead check out the \`onig\` crate."
HOMEPAGE="https://github.com/iwillspeak/rust-onig"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"generate"
	"posix-api"
	"print-debug"
)
