# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_complete"
CRATE_VERSION="4.5.57"
CRATE_CHECKSUM="4d9501bd3f5f09f7bbee01da9a511073ed30a80cd7a509f1214bb74eadea71ad"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate shell completion scripts for your clap::Command"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"unstable-doc"
	"unstable-dynamic"
	"unstable-shell-tests"
)
