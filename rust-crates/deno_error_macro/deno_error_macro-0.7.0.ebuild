# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_error_macro"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="409f265785bd946d3006756955aaf40b0e4deb25752eae6a990afe54a31cfd83"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for writing Deno errors"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
