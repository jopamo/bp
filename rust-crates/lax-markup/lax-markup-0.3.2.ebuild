# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="lax-markup"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="0b6f67a7a729b68c4b8e6f45315b0777fdf9618cfd569d4551d14d0906b93306"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lax HTML, XML, SVG, and component (Vue, Svelte, Astro) formatter that never reinterprets your markup. Usable as a library or a dprint plugin."
HOMEPAGE="https://github.com/bartlomieju/lax"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"wasm"
)
