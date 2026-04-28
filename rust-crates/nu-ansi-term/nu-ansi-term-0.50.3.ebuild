# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="nu-ansi-term"
CRATE_VERSION="0.50.3"
CRATE_CHECKSUM="7957b9740744892f114936ab4a57b3f487491bbeafaf8083688b16841a4240e5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for ANSI terminal colors and styles (bold, underline)"
HOMEPAGE="https://github.com/nushell/nu-ansi-term"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"derive_serde_style"
	"gnu_legacy"
	"std"
)
