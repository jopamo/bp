# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="redox_syscall"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="49f3fe0889e69e2ae9e41f4d6c4c0181701d00e4697b356fb1f74173a5e0ee27"
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
