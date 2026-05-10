# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="priority-queue"
CRATE_VERSION="2.5.0"
CRATE_CHECKSUM="5676d703dda103cbb035b653a9f11448c0a7216c7926bd35fcb5865475d0c970"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Priority Queue implemented as a heap with a function to efficiently change the priority of an item."
HOMEPAGE="https://github.com/garro95/priority-queue"
LICENSE="|| ( LGPL-3.0-or-later MPL-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"benchmarks"
	"default"
	"std"
)
