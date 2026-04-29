# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="env_logger"
CRATE_VERSION="0.11.8"
CRATE_CHECKSUM="13c863f0904021b108aa8b2f55046443e6b1ebde8fd4a15c399893aae4fa069f"
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
