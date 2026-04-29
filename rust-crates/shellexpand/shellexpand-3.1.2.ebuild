# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="shellexpand"
CRATE_VERSION="3.1.2"
CRATE_CHECKSUM="32824fab5e16e6c4d86dc1ba84489390419a39f97699852b66480bb87d297ed8"
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
