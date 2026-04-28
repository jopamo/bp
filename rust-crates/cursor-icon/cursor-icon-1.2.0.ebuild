# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cursor-icon"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="f27ae1dd37df86211c42e150270f82743308803d90a6f6e6651cd730d5e1732f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross platform cursor icon type"
HOMEPAGE="https://github.com/rust-windowing/cursor-icon"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
