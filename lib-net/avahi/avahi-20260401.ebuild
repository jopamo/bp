# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="mDNS/DNS-SD client libraries and browsing tools"
HOMEPAGE="https://www.avahi.org/"
SNAPSHOT=0cb52a89a11095c6d673e5ea9e2cdfaf77222aff
SRC_URI="https://github.com/avahi/avahi/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="!test? ( test )"

RDEPEND="
	app-core/dbus
	lib-core/expat
	lib-core/glib
	lib-dev/libevent
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-build/gettext
	app-build/libtool
	app-dev/pkgconf
"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-gdbm
		--disable-introspection
		--disable-qt3
		--disable-qt4
		--disable-qt5
		--disable-gtk
		--disable-gtk3
		--disable-libdaemon
		--disable-libsystemd
		--disable-mono
		--disable-python
		--disable-doxygen-doc
		--disable-xmltoman
		--disable-manpages
		--enable-dbus
		--enable-glib
		--enable-gobject
		--enable-libevent
		--with-distro=none
		$(use_enable test tests)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_test() {
	emake check
}

src_install() {
	default

	rm -rf "${ED}"/var
	rm -rf "${ED}"/usr/share/man

	qa-policy-install
}
