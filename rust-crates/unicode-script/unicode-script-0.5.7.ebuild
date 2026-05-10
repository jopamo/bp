# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-script"
CRATE_VERSION="0.5.7"
CRATE_CHECKSUM="9fb421b350c9aff471779e262955939f565ec18b86c15364e6bdf0d662ca7c1f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate exposes the Unicode \`Script\` and \`Script_Extension\` properties from [UAX #24](http://www.unicode.org/reports/tr24/)"
HOMEPAGE="https://github.com/unicode-rs/unicode-script"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench"
	"rustc-dep-of-std"
)
