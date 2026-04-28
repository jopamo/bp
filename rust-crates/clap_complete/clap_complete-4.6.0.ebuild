# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_complete"
CRATE_VERSION="4.6.0"
CRATE_CHECKSUM="19c9f1dde76b736e3681f28cec9d5a61299cbaae0fce80a68e43724ad56031eb"
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
