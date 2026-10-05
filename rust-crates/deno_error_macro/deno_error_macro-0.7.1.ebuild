# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_error_macro"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="1c28ede88783f14cd8aae46ca89f230c226b40e4a81ab06fa52ed72af84beb2f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for writing Deno errors"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
