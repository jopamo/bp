# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="anyhow"
CRATE_VERSION="1.0.103"
CRATE_CHECKSUM="2a4385e2e34eb35d6b3efe798b9eb88096925d87726c0798709bf56d9ed84af3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Flexible concrete Error type built on std::error::Error"
HOMEPAGE="https://github.com/dtolnay/anyhow"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"backtrace"
	"default"
	"std"
)
