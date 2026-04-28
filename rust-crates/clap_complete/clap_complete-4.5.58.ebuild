# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_complete"
CRATE_VERSION="4.5.58"
CRATE_CHECKSUM="75bf0b32ad2e152de789bb635ea4d3078f6b838ad7974143e99b99f45a04af4a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate shell completion scripts for your clap::Command"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"unstable-doc"
	"unstable-dynamic"
	"unstable-shell-tests"
)
