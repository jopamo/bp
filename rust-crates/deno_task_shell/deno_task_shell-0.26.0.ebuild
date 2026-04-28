# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_task_shell"
CRATE_VERSION="0.26.0"
CRATE_CHECKSUM="8ec9c589f733da0f5dfdf475d44cd01e2087425839a55162538d9898e94556e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross platform scripting for deno task"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serialization"
	"shell"
)
