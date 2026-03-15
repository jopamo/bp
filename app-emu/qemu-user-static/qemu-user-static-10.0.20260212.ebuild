# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="stable-$(ver_cut 1-2)"

inherit flag-o-matic qa-policy

DESCRIPTION="QEMU with enhanced support for multiple architectures and options"
HOMEPAGE="https://www.qemu.org/"
SNAPSHOT=bb779689554ca5e69e0ac0bb56f90c41c64a80bb
SOFTFLOAT_SNAPSHOT=b64af41c3276f97f0e181920400ee056b9c88037
TESTFLOAT_SNAPSHOT=e7af9751d9f9fd3b47911f51a5cfd08af256a9ab
SRC_URI="
	https://github.com/qemu/qemu/archive/${SNAPSHOT}.tar.gz -> qemu-${SNAPSHOT}.tar.gz
	https://gitlab.com/qemu-project/berkeley-softfloat-3/-/archive/${SOFTFLOAT_SNAPSHOT}/berkeley-softfloat-3-${SOFTFLOAT_SNAPSHOT}.tar.gz
	https://gitlab.com/qemu-project/berkeley-testfloat-3/-/archive/${TESTFLOAT_SNAPSHOT}/berkeley-testfloat-3-${TESTFLOAT_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/qemu-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs xattr"

DEPEND="
    virtual/linux-sources
    lib-core/zlib[static-libs(+)]
    lib-dev/libtasn1[static-libs(+)]
    lib-core/glib[static-libs(+)]
    xattr? ( app-core/attr[static-libs(+)] )
"

BDEPEND="
	app-dev/dtc
"

src_prepare() {
	filter-flags -Wl,-z,defs -flto*

	rm -rf subprojects/berkeley-softfloat-3 || die
	cp -a "${WORKDIR}/berkeley-softfloat-3-${SOFTFLOAT_SNAPSHOT}" subprojects/berkeley-softfloat-3 || die
	cp -a subprojects/packagefiles/berkeley-softfloat-3/. subprojects/berkeley-softfloat-3/ || die

	rm -rf subprojects/berkeley-testfloat-3 || die
	cp -a "${WORKDIR}/berkeley-testfloat-3-${TESTFLOAT_SNAPSHOT}" subprojects/berkeley-testfloat-3 || die
	cp -a subprojects/packagefiles/berkeley-testfloat-3/. subprojects/berkeley-testfloat-3/ || die

	default
	mkdir -p build
}

src_configure() {
	cd build
	qa-policy-configure
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
		--without-default-features
		--disable-download
		--disable-system
		--disable-werror
		--enable-linux-user
		--disable-linux-aio
		--disable-linux-io-uring
		--enable-membarrier
		$(use_enable xattr attr)
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
	qa-policy-install

	rm -rf "${ED}"/usr/share || die

	cd "${ED}"/usr/bin || die
	local bin
	for bin in *; do
		[[ -e ${bin} ]] || continue
		mv "${bin}" "${bin}-static" || die
	done
}
