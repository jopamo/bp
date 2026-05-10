# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="open"
CRATE_VERSION="5.3.2"
CRATE_CHECKSUM="e2483562e62ea94312f3576a7aca397306df7990b8d89033e18766744377ef95"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Open a path or URL using the program configured on the system"
HOMEPAGE="https://github.com/Byron/open-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"shellexecute-on-windows"
)
