# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cyclonedx-bom-macros"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="c50341f21df64b412b4f917e34b7aa786c092d64f3f905f478cb76950c7e980c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macros used internally by the \`cyclonedx-bom\` crate"
HOMEPAGE="https://cyclonedx.org/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
