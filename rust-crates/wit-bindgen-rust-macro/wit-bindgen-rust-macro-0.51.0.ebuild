# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wit-bindgen-rust-macro"
CRATE_VERSION="0.51.0"
CRATE_CHECKSUM="0c0f9bfd77e6a48eccf51359e3ae77140a7f50b1e2ebfe62422d8afdaffab17a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macro paired with the `wit-bindgen` crate."
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"async"
)
