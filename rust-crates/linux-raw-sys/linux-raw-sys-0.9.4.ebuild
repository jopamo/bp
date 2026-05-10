# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="linux-raw-sys"
CRATE_VERSION="0.9.4"
CRATE_CHECKSUM="cd945864f07fe9f5371a27ad7b52a172b4b499999f1d97574c9fa68373937e12"
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
	"xdp"
)
