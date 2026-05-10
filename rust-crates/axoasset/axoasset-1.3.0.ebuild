# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="axoasset"
CRATE_VERSION="1.3.0"
CRATE_CHECKSUM="56b3b6c5d71b918c0f42f43f69b303d7529b4233a598d9d61759d75f0f2a44a2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION=">o_o<"
HOMEPAGE="https://github.com/axodotdev/axoasset"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compression"
	"compression-tar"
	"compression-zip"
	"default"
	"json-serde"
	"remote"
	"tls-native-roots"
	"toml-edit"
	"toml-serde"
	"yaml-serde"
)
