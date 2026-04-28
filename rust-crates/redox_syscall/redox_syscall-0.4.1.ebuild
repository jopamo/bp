# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="redox_syscall"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="4722d768eff46b75989dd134e5c353f0d6296e5aaa3132e776cbdb56be7731aa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust library to access raw Redox system calls"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/syscall"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"rustc-dep-of-std"
)
