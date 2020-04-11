# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/qemu/qemu.git"
	inherit git-r3
else
	SRC_URI="http://wiki.qemu-project.org/download/${P}.tar.bz2"
fi

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+fdt gnutls iscsi nettle seccomp zstd"

DEPEND="
	lib-dev/glib
	lib-dev/libpcre
	lib-sys/zlib
	sys-app/attr
	fdt? ( sys-app/dtc )
	gnutls? ( lib-net/gnutls )
	iscsi? ( lib-net/libiscsi )
	nettle? ( lib-dev/nettle )
	seccomp? ( lib-sys/libseccomp )
	zstd? ( app-compression/zstd )
"

QA_PREBUILT="
	usr/share/qemu/hppa-firmware.img
	usr/share/qemu/openbios-ppc
	usr/share/qemu/openbios-sparc64
	usr/share/qemu/openbios-sparc32
	usr/share/qemu/palcode-clipper
	usr/share/qemu/s390-ccw.img
	usr/share/qemu/s390-netboot.img
	usr/share/qemu/u-boot.e500"

QA_WX_LOAD="
	usr/bin/qemu-x86_64
	usr/bin/qemu-aarch64"

filter-flags -Wl,-z,defs -Wl,-z,relro

src_configure() {
	local myconf=(
		$(use_enable fdt)
		$(use_enable gnutls)
		$(use_enable iscsi libiscsi)
		$(use_enable nettle)
		$(use_enable seccomp)
		$(use_enable zstd)
		--enable-attr
		--disable-gtk
		--target-list=x86_64-softmmu,aarch64-softmmu,aarch64-linux-user,x86_64-linux-user
		--disable-strip
		--disable-werror
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	rm -rf "${ED}"/var/run
}
