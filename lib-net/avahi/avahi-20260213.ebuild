# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="Service Discovery for Linux using mDNS"
HOMEPAGE="https://www.avahi.org/"
SNAPSHOT=f62e34b8cf9c94c6e9dfeb993295356a8a3fd14f
SRC_URI="https://github.com/avahi/avahi/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	use static-libs && lto-guarantee-fat

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-qt3
		--disable-qt4
		--disable-qt5
		--disable-gtk
		--disable-gtk3
		--disable-python-dbus
		--disable-mono
		--disable-monodoc
		--disable-pygobject
		--disable-doxygen-doc
		--disable-xmltoman
		--with-distro=none
		--disable-manpages
		--disable-libdaemon
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}


src_install() {
	default
	use static-libs && strip-lto-bytecode

	rm -rf "${ED}"/var
	rm -rf "${ED}"/usr/share/man
}
