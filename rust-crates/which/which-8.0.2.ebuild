# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="which"
CRATE_VERSION="8.0.2"
CRATE_CHECKSUM="81995fafaaaf6ae47a7d0cc83c67caf92aeb7e5331650ae6ff856f7c0c60c459"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust equivalent of Unix command \"which\". Locate installed executable in cross platforms."
HOMEPAGE="https://github.com/harryfei/which-rs.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"real-sys"
	"regex"
	"tracing"
)
