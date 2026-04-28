# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_media_type"
CRATE_VERSION="0.2.9"
CRATE_CHECKSUM="f0ec0dada9dc5ac4733b4175d36f6a150b7dd68fab46db35cb1ef00dd7366acb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Media type used in Deno"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"data_url"
	"decoding"
	"default"
	"module_specifier"
)
