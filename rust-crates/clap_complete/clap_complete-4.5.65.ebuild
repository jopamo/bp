# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_complete"
CRATE_VERSION="4.5.65"
CRATE_CHECKSUM="430b4dc2b5e3861848de79627b2bedc9f3342c7da5173a14eaa5d0f8dc18ae5d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate shell completion scripts for your clap::Command"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"unstable-doc"
	"unstable-dynamic"
	"unstable-shell-tests"
)
