# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="gl_generator"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="1a95dfc23a2b4a9a2f5ab41d194f8bfda3cabec42af4e39f08c339eb2a0c124d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Code generators for creating bindings to the Khronos OpenGL APIs."
HOMEPAGE="https://github.com/brendanzab/gl-rs/"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"unstable_generator_utils"
)
