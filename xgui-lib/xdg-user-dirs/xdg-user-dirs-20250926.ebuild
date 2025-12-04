# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a tool to help manage well known user directories"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/xdg-user-dirs/"
SNAPSHOT=52e0e422d918062bae5feb39b7af038e9b1e5c0e
SRC_URI="https://gitlab.freedesktop.org/xdg/xdg-user-dirs/-/archive/${SNAPSHOT}/xdg-user-dirs-${SNAPSHOT}.tar.bz2 -> xdg-user-dirs-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xdg-user-dirs-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	rm -rf autom4te.cache/
	rm -f config.log config.cache config.status
	rm -f Makefile Makefile.in
	rm -f aclocal.m4
	rm -f configure
	rm -f *.o *.lo *.la *.a
	rm -f libtool ltmain.sh

	sed -i 's| Makefile.in.in Makevars $(top_builddir)/config.status @POMAKEFILEDEPS@| Makefile.in.in Makevars @POMAKEFILEDEPS@|' \
		po/Makefile.in.in

	sed -i '/cd $(top_builddir).*config.status/d' po/Makefile.in.in

	sed -i 's/@POMAKEFILEDEPS@//g' po/Makefile.in.in



	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
