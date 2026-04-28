# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="redox_syscall"
CRATE_VERSION="0.7.3"
CRATE_CHECKSUM="6ce70a74e890531977d37e532c34d45e9055d2409ed08ddba14529471ed0be16"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust library to access raw Redox system calls"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/syscall"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
	"std"
	"userspace"
)
