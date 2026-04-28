# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="markup_fmt"
CRATE_VERSION="0.22.0"
CRATE_CHECKSUM="2cc6a5130d40b34be77fbd52645323c199d2db25f90922d5cef1da2a9eca96b0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Configurable HTML, Vue, Svelte, Astro, Angular, Jinja, Twig, Nunjucks, Vento, Mustache and XML formatter."
HOMEPAGE="https://github.com/g-plane/markup_fmt"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"config_serde"
)
