# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tracing-subscriber"
CRATE_VERSION="0.3.22"
CRATE_CHECKSUM="2f30143827ddab0d256fd843b7a66d164e9f271cfa0dde49142c5ca0ca291f1e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for implementing and composing \`tracing\` subscribers."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"ansi"
	"default"
	"env-filter"
	"fmt"
	"json"
	"local-time"
	"nu-ansi-term"
	"regex"
	"registry"
	"std"
	"valuable"
)
