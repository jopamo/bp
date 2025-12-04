# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info toolchain-funcs autotools

DESCRIPTION="The libxdp library and various tools for use with XDP"
HOMEPAGE="https://github.com/xdp-project/xdp-tools"
SNAPSHOT=ef5e0999229e5ce830000329d42456a68f7b2b56
SRC_URI="https://github.com/xdp-project/xdp-tools/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+tools"

DEPEND="
	lib-net/libbpf:=
	lib-net/libpcap
	lib-core/zlib
	virtual/libelf
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-core/grep[pcre]
	app-build/llvm:*[bpf]
	app-build/m4
"

# Not prebuilt -- we build them -- but they're not ordinary ELF objects either.
QA_PREBUILT="usr/lib/bpf/*.o"

MAKEOPTS+=" V=1"

CONFIG_CHECK="~BPF ~BPF_JIT ~BPF_SYSCALL ~HAVE_EBPF_JIT ~XDP_SOCKETS ~XDP_SOCKETS_DIAG"

src_prepare() {
	# remove -Werror: #899744
	sed -i 's/-Werror//g' lib/Makefile lib/defines.mk || die
	sed -i '/-Werror/d' lib/common.mk lib/libxdp/Makefile \
		lib/libxdp/tests/Makefile lib/util/Makefile || die

	default
}

src_configure() {
	# filter LTO: #861587
	filter-lto

	# filter LDFLAGS some more: #916591
	filter-ldflags -Wl,--{icf,lto}*

	export CC="$(tc-getCC)"
	export PREFIX="${EPREFIX}/usr"
	export LIBDIR="${PREFIX}/lib"
	export SBINDIR="${PREFIX}/bin"
	export BPF_OBJECT_DIR="${PREFIX}/lib/bpf"
	export PRODUCTION=1
	export DYNAMIC_LIBXDP=1
	export FORCE_SYSTEM_LIBBPF=1

	default
}

src_test() { :; }

src_install() {
	default

	# To remove the scripts/testing files that are installed.
	rm -r "${ED}/usr/share/xdp-tools" || die
	# We can't control static archive generation yet.
	rm "${ED}/usr/lib/libxdp.a" || die

	use tools || { rm "${ED}/usr/bin"/* || die; }

	# These are ELF objects but BPF ones.
	dostrip -x /usr/lib/bpf
}

pkg_postinst() {
	elog
	elog "Many BPF utilities need access to a mounted bpffs virtual file system."
	elog "Either mount it manually like this:"
	elog
	elog "  mount bpffs /sys/fs/bpf -t bpf -o nosuid,nodev,noexec,relatime,mode=700"
	elog
	elog "or add the following line to your /etc/fstab to always mount it at boot time:"
	elog
	elog "  bpffs  /sys/fs/bpf  bpf  nosuid,nodev,noexec,relatime,mode=700  0 0"
	elog
	elog "You can verify that bpffs is mounted with:"
	elog
	elog "  mount | grep /sys/fs/bpf"
	elog
}
