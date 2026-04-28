# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="env_logger"
CRATE_VERSION="0.10.2"
CRATE_CHECKSUM="4cd405aab171cb85d6735e5c8d9db038c17d3ca007a4d2c25f337935c3d90580"
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
	"regex"
)
