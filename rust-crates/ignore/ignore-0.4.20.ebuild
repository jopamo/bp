# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ignore"
CRATE_VERSION="0.4.20"
CRATE_CHECKSUM="dbe7873dab538a9a44ad79ede1faf5f30d49f9a5c883ddbab48bce81b64b7492"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast library for efficiently matching ignore files such as `.gitignore` against file paths."
HOMEPAGE="https://github.com/BurntSushi/ripgrep/tree/master/crates/ignore"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"simd-accel"
)
