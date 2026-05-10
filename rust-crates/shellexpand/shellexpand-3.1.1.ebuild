# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="shellexpand"
CRATE_VERSION="3.1.1"
CRATE_CHECKSUM="8b1fdf65dd6331831494dd616b30351c38e96e45921a27745cf98490458b90bb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shell-like expansions in strings"
HOMEPAGE="https://gitlab.com/ijackson/rust-shellexpand"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"base-0"
	"default"
	"full"
	"full-msrv-1-31"
	"full-msrv-1-51"
	"path"
	"tilde"
)
