# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="miette"
CRATE_VERSION="7.6.0"
CRATE_CHECKSUM="5f98efec8807c63c752b5bd61f862c165c115b0a35685bdcfd9238c7aeb592b7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fancy diagnostic reporting library and protocol for us mere mortals who aren't compiler hackers."
HOMEPAGE="https://github.com/zkat/miette"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"derive"
	"fancy"
	"fancy-base"
	"fancy-no-backtrace"
	"fancy-no-syscall"
	"no-format-args-capture"
	"syntect-highlighter"
)
