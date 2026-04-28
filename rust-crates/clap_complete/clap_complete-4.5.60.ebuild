# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_complete"
CRATE_VERSION="4.5.60"
CRATE_CHECKSUM="8e602857739c5a4291dfa33b5a298aeac9006185229a700e5810a3ef7272d971"
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
