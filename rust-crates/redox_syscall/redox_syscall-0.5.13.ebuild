# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="redox_syscall"
CRATE_VERSION="0.5.13"
CRATE_CHECKSUM="0d04b7d0ee6b4a0207a0a7adb104d23ecb0b47d6beae7152d0fa34b692b29fd6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust library to access raw Redox system calls"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/syscall"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
	"std"
	"userspace"
)
