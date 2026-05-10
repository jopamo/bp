# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libredox"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="4488594b9328dee448adb906d8b126d9b7deb7cf5c22161ee591610bb1be83c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Redox stable ABI"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/libredox.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"call"
	"default"
	"mkns"
	"std"
)
