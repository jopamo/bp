# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="futures-core"
CRATE_VERSION="0.3.31"
CRATE_CHECKSUM="05f29059c0c2090612e8d742178b0580d2dc940c837851ad723096f87af6663e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The core traits and types in for the \`futures\` library."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"cfg-target-has-atomic"
	"default"
	"std"
	"unstable"
)
