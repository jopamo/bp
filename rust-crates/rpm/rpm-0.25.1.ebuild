# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rpm"
CRATE_VERSION="0.25.1"
CRATE_CHECKSUM="3a5c5d43b95d73d6f0a1b8fbeab72a7ebebf618cdc99f2b9a28f269ee343766e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A pure rust library for building and parsing RPMs"
HOMEPAGE="https://github.com/rpm-rs/rpm"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bzip2-compression"
	"default"
	"gzip-compression"
	"payload"
	"python"
	"signature-meta"
	"signature-pgp"
	"test-with-podman"
	"xz-compression"
	"zstd-compression"
	"zstdmt"
)
