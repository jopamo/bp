# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="encoding_rs_io"
CRATE_VERSION="0.1.7"
CRATE_CHECKSUM="1cc3c5651fb62ab8aa3103998dade57efdd028544bd300516baa31840c252a83"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Streaming transcoding for encoding_rs"
HOMEPAGE="https://github.com/BurntSushi/encoding_rs_io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
