# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="QEMU with enhanced support for multiple architectures and options"
HOMEPAGE="https://www.qemu.org/"
SRC_URI="https://download.qemu.org/qemu-${PV}.tar.xz"
S="${WORKDIR}/qemu-${PV}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+static-libs xattr"

DEPEND="
    app-kernel/linux-headers
    lib-core/zlib[static-libs(+)]
    lib-dev/libtasn1[static-libs(+)]
    lib-util/glib[static-libs(+)]
    xattr? ( app-core/attr[static-libs(+)] )
"

src_prepare() {
	filter-flags -Wl,-z,defs -flto*

	default
	mkdir -p build
}

src_configure() {
	cd build

	local myconf=(
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--includedir="${EPREFIX}"/usr/include
		--datadir="${EPREFIX}"/usr/share
		--mandir="${EPREFIX}"/usr/share/man
		--infodir="${EPREFIX}"/usr/share/info
		--static
		--disable-system
		--enable-linux-user
		--enable-kvm
		--enable-qcow1
		--enable-virtfs
		--enable-vhost-crypto
		--enable-vhost-kernel
		--enable-vhost-net
		--enable-vhost-user
		--target-list="aarch64-linux-user arm-linux-user x86_64-linux-user"
	)
	../configure "${myconf[@]}"
}

src_compile() {
	cd build

	emake

}

src_install() {
	cd build
	emake DESTDIR="${ED}" install

	rm -rf cd "${ED}"/usr/share
	cd "${ED}"/usr/bin
	for i in *; do mv $i $i-static; done
}
