# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_lint"
CRATE_VERSION="0.80.0"
CRATE_CHECKSUM="816be0fe885ac88b200d73d99f8c9557278ff416acf8abc1661b46837f09a303"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="lint for deno"
HOMEPAGE="https://github.com/denoland/deno_lint"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
)
