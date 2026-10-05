# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_media_type"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="debab24ecd9f4fd64aa42fb18a02dff20a97d5830b2b85b98ce70b509f790763"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Media type used in Deno"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"data_url"
	"decoding"
	"default"
	"module_specifier"
)
