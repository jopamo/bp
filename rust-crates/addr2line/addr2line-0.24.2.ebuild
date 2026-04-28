# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="addr2line"
CRATE_VERSION="0.24.2"
CRATE_CHECKSUM="dfbe277e56a376000877090da837660b4427aad530e3028d44e0bffe4f89a1c1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A cross-platform symbolication library written in Rust, using `gimli`"
HOMEPAGE="https://github.com/gimli-rs/addr2line"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"all"
	"bin"
	"cargo-all"
	"default"
	"loader"
	"rustc-dep-of-std"
	"std"
)
