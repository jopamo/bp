# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="env_logger"
CRATE_VERSION="0.11.11"
CRATE_CHECKSUM="de671bd27a75a797dc9ae289ba1e77276e75e2026408aab65185384e2d5cd3f6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A logging implementation for \`log\` which is configured via an environment variable."
HOMEPAGE="https://github.com/rust-cli/env_logger"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"auto-color"
	"color"
	"default"
	"humantime"
	"kv"
	"regex"
	"unstable-kv"
)
