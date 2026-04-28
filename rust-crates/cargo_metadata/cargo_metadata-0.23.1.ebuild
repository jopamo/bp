# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo_metadata"
CRATE_VERSION="0.23.1"
CRATE_CHECKSUM="ef987d17b0a113becdd19d3d0022d04d7ef41f9efe4f3fb63ac44ba61df3ade9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="structured access to the output of \`cargo metadata\`"
HOMEPAGE="https://github.com/oli-obk/cargo_metadata"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"builder"
	"default"
	"unstable"
)
