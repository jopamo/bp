# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="linux-raw-sys"
CRATE_VERSION="0.11.0"
CRATE_CHECKSUM="df1d3c3b53da64cf5760482273a98e575c651a67eec7f77df96b5b642de8f039"
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
