# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils flag-o-matic gnome2-utils multilib

MY_PV=${PV/_/-}
MY_P="FileZilla_${MY_PV}"

DESCRIPTION="FTP client with lots of useful features and an intuitive interface"
HOMEPAGE="http://filezilla-project.org/"
SRC_URI="https://sources.voidlinux.org/filezilla-3.36.0/${MY_P}_src.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="dbus nls test"

RDEPEND=">=lib-dev/nettle-3.1:=
	>=lib-sys/sqlite-3.7
	>=lib-dev/libfilezilla-0.12.1
	>=lib-dev/pugixml-1.7
	>=lib-net/gnutls-3.4.0
	x11-libs/wxGTK[X]
	x11/xdg-utils
	dbus? ( sys-app/dbus )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/libtool-1.4
	nls? ( >=sys-devel/gettext-0.11 )
	test? ( dev-util/cppunit )"

S="${WORKDIR}"/${PN}-${MY_PV}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_with dbus)
		$(use_enable nls locales)
		--with-pugixml=system
		--disable-autoupdatecheck
	)
	econf ${myconf[@]}
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
