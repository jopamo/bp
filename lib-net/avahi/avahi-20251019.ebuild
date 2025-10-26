# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Service Discovery for Linux using mDNS"
HOMEPAGE="https://www.avahi.org/"
SNAPSHOT=2e69fea69190ba13798362ef0819b4e0d41336a0
SRC_URI="https://github.com/avahi/avahi/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
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
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}


src_install() {
	default

	rm -rf "${ED}"/var
	rm -rf "${ED}"/usr/share/man
}
