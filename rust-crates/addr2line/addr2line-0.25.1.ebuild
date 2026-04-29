# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="addr2line"
CRATE_VERSION="0.25.1"
CRATE_CHECKSUM="1b5d307320b3181d6d7954e663bd7c774a838b8220fe0593c86d9fb09f498b4b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A cross-platform symbolication library written in Rust, using \`gimli\`"
HOMEPAGE="https://github.com/gimli-rs/addr2line"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all"
	"bin"
	"cargo-all"
	"default"
	"loader"
	"rustc-dep-of-std"
	"std"
	"wasm"
)
