# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="diskus"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="ec07379c016f78e7ddcd953663b9ed17928ff384928d34d824ed7e463bd3d908"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A minimal, fast alternative to 'du -sh'."
HOMEPAGE="https://github.com/sharkdp/diskus"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cli"
	"default"
)
