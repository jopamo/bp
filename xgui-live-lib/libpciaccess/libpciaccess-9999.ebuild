# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Library providing generic access to the PCI bus and devices"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"
else
	SRC_URI="https://www.x.org/archive/individual/lib/${P}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="zlib static-libs"

DEPEND="!<xgui-misc/xorg-server-1.5
	zlib? (	>=lib-core/zlib-1.2.8-r1:= )"
RDEPEND="${DEPEND}
	app-core/systemd"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_with zlib)
		--with-pciids-path=${EPREFIX}/usr/share/misc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
