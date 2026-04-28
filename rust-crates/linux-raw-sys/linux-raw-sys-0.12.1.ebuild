# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="linux-raw-sys"
CRATE_VERSION="0.12.1"
CRATE_CHECKSUM="32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generated bindings for Linux's userspace API"
HOMEPAGE="https://github.com/sunfishcode/linux-raw-sys"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"auxvec"
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
	"if_tun"
	"image"
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
	"vm_sockets"
	"xdp"
)
