# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo-lock"
CRATE_VERSION="10.1.0"
CRATE_CHECKSUM="c06acb4f71407ba205a07cb453211e0e6a67b21904e47f6ba1f9589e38f2e454"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Self-contained Cargo.lock parser with optional dependency graph analysis"
HOMEPAGE="https://rustsec.org"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cli"
	"dependency-tree"
)
