# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="linux-raw-sys"
CRATE_VERSION="0.4.15"
CRATE_CHECKSUM="d26c52dbd32dccf2d10cac7725f8eae5296885fb5703b261f7d0a0739ec807ab"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generated bindings for Linux's userspace API"
HOMEPAGE="https://github.com/sunfishcode/linux-raw-sys"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bootparam"
	"btrfs"
	"default"
	"elf"
	"elf_uapi"
	"errno"
	"general"
	"if_arp"
	"if_ether"
	"if_packet"
	"io_uring"
	"ioctl"
	"landlock"
	"loop_device"
	"mempolicy"
	"net"
	"netlink"
	"no_std"
	"prctl"
	"ptrace"
	"rustc-dep-of-std"
	"std"
	"system"
	"xdp"
)
