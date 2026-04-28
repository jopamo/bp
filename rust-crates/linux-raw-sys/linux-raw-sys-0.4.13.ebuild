# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="linux-raw-sys"
CRATE_VERSION="0.4.13"
CRATE_CHECKSUM="01cda141df6706de531b6c46c3a33ecca755538219bd484262fa09410c13539c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generated bindings for Linux's userspace API"
HOMEPAGE="https://github.com/sunfishcode/linux-raw-sys"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"elf"
	"errno"
	"general"
	"if_ether"
	"if_packet"
	"io_uring"
	"ioctl"
	"mempolicy"
	"net"
	"netlink"
	"no_std"
	"prctl"
	"rustc-dep-of-std"
	"std"
	"system"
	"xdp"
)
