# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="redox_syscall"
CRATE_VERSION="0.5.15"
CRATE_CHECKSUM="7e8af0dde094006011e6a740d4879319439489813bd0bcdc7d821beaeeff48ec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust library to access raw Redox system calls"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/syscall"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
	"std"
	"userspace"
)
