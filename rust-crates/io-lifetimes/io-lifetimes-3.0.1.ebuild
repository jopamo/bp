# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="io-lifetimes"
CRATE_VERSION="3.0.1"
CRATE_CHECKSUM="2f0fb0570afe1fed943c5c3d4102d5358592d8625fda6a0007fdbe65a92fba96"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A low-level I/O ownership and borrowing library"
HOMEPAGE="https://github.com/sunfishcode/io-lifetimes"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"close"
	"default"
)
