# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstream"
CRATE_VERSION="0.6.15"
CRATE_CHECKSUM="64e15c1ab1f89faffbf04a634d5e1962e9074f2741eef6d97f3c4e322426d526"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple cross platform library for writing colored text to a terminal."
HOMEPAGE="https://github.com/rust-cli/anstyle"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"auto"
	"default"
	"test"
	"wincon"
)
