# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="par-core"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="e96cbd21255b7fb29a5d51ef38a779b517a91abd59e2756c039583f43ef4c90f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Switchable parallel execution core"
HOMEPAGE="https://github.com/dudykr/ddbase.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"chili"
	"default"
	"parallel"
	"rayon"
)
