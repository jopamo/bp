# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

MY_PV=${PV/_/.}-3

DESCRIPTION="Device-mapper RAID tool and library"
HOMEPAGE="https://people.redhat.com/~heinzm/sw/dmraid/"
SRC_URI="https://people.redhat.com/~heinzm/sw/dmraid/src/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="intel_led led mini static"

RDEPEND=">=sys-fs/lvm2-2.02.45"
DEPEND="${RDEPEND}
	static? ( sys-fs/lvm2[static-libs] )
"

S="${WORKDIR}/${PN}/${MY_PV}/${PN}"

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	eapply	"${FILESDIR}"/${P}-undo-p-rename.patch \
		"${FILESDIR}"/${P}-return-all-sets.patch \
		"${FILESDIR}"/${P}-static-build-fixes.patch \
		"${FILESDIR}"/${P}-parallel-make.patch
	# pkg_check_modules is not in aclocal.m4 by default, and eautoreconf doesnt add it
	einfo "Appending pkg.m4 from system to aclocal.m4"
	cat "${ROOT}"/usr/share/aclocal/pkg.m4 >>"${S}"/aclocal.m4 || die "Could not append pkg.m4"
	eapply_user
	eautoreconf

	einfo "Creating prepatched source archive for use with Genkernel"
	# archive the patched source for use with genkernel
	cd "${WORKDIR}" || die
	mkdir -p "tmp/${PN}" || die
	cp -a "${PN}/${MY_PV}/${PN}" "tmp/${PN}" || die
	mv "tmp/${PN}/${PN}" "tmp/${PN}/${MY_PV}" || die
	cd tmp || die
	tar -jcf ${PN}-${MY_PV}-prepatched.tar.bz2 ${PN} || die
	mv ${PN}-${MY_PV}-prepatched.tar.bz2 .. || die
}

src_configure() {
	# disable klibc and dietlibc, bug #653392
	econf --with-usrlibdir='${prefix}'/$(get_libdir) \
		--disable-klibc \
		--disable-dietlibc \
		$(use_enable static static_link) \
		$(use_enable mini) \
		$(use_enable led) \
		$(use_enable intel_led)
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /usr/share/${PN}
	doins "${WORKDIR}"/${PN}-${MY_PV}-prepatched.tar.bz2
}
