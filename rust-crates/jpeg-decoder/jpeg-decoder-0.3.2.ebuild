# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jpeg-decoder"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="00810f1d8b74be64b13dbf3db89ac67740615d6c891f0e7b6179326533011a07"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="JPEG decoder"
HOMEPAGE="https://github.com/image-rs/jpeg-decoder"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly_aarch64_neon"
	"platform_independent"
)
