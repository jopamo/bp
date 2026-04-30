# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tracing-subscriber"
CRATE_VERSION="0.3.23"
CRATE_CHECKSUM="cb7f578e5945fb242538965c2d0b04418d38ec25c79d160cd279bf0731c8d319"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for implementing and composing \`tracing\` subscribers."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"ansi"
	"default"
	"env-filter"
	"fmt"
	"json"
	"local-time"
	"nu-ansi-term"
	"regex"
	"registry"
	"std"
	"valuable"
)
