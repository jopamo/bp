# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_complete_nushell"
CRATE_VERSION="4.5.10"
CRATE_CHECKSUM="685bc86fd34b7467e0532a4f8435ab107960d69a243785ef0275e571b35b641a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A generator library used with clap for Nushell completion scripts"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"unstable-shell-tests"
)
