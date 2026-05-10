# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ambient-id"
CRATE_VERSION="0.0.8"
CRATE_CHECKSUM="41c211637568dac6885fe10628aade8c3340c516e47460671bcafee0a3fb8d43"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Detects ambient OIDC credentials in a variety of environments"
HOMEPAGE="https://github.com/astral-sh/ambient-id"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"test-buildkite-1p"
	"test-circleci-1p"
	"test-github-1p"
)
