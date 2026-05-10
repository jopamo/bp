# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral_async_http_range_reader"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="7ddaca0fbbf0d91103cca7c7611790c65f6eff1d456f7fe6bf565d436dc9b8f3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for streaming reading of files over HTTP using range requests"
HOMEPAGE="https://github.com/prefix-dev/async_http_range_reader"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
