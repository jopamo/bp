# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="env_logger"
CRATE_VERSION="0.11.6"
CRATE_CHECKSUM="dcaee3d8e3cfc3fd92428d477bc97fc29ec8716d180c0d74c643bb26166660e0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A logging implementation for \`log\` which is configured via an environment variable."
HOMEPAGE="https://github.com/rust-cli/env_logger"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"auto-color"
	"color"
	"default"
	"humantime"
	"regex"
	"unstable-kv"
)
