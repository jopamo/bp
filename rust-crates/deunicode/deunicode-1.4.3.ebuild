# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deunicode"
CRATE_VERSION="1.4.3"
CRATE_CHECKSUM="b6e854126756c496b8c81dec88f9a706b15b875c5849d4097a3854476b9fdf94"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Convert Unicode strings to pure ASCII by intelligently transliterating them. Suppors Emoji and Chinese."
HOMEPAGE="https://lib.rs/crates/deunicode"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
)
