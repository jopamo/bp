# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libredox"
CRATE_VERSION="0.1.16"
CRATE_CHECKSUM="e02f3bb43d335493c96bf3fd3a321600bf6bd07ed34bc64118e9293bdffea46c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Redox stable ABI"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/libredox.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"base"
	"call"
	"default"
	"mkns"
	"protocol"
	"std"
)
