# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rcgen"
CRATE_VERSION="0.14.6"
CRATE_CHECKSUM="3ec0a99f2de91c3cddc84b37e7db80e4d96b743e05607f647eb236fc0455907f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust X.509 certificate generator"
HOMEPAGE="https://github.com/rustls/rcgen"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws_lc_rs"
	"aws_lc_rs_unstable"
	"crypto"
	"default"
	"fips"
	"ring"
)
