# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="redox_syscall"
CRATE_VERSION="0.5.17"
CRATE_CHECKSUM="5407465600fb0548f1442edf71dd20683c6ed326200ace4b1ef0763521bb3b77"
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
