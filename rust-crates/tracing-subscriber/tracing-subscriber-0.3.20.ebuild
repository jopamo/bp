# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tracing-subscriber"
CRATE_VERSION="0.3.20"
CRATE_CHECKSUM="2054a14f5307d601f88daf0553e1cbf472acc4f2c51afab632431cdcd72124d5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for implementing and composing `tracing` subscribers."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
