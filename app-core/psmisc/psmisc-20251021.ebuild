# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
SNAPSHOT=f3b51bdc90b6b5cb610528cce3d8262a932d50f0
SRC_URI="https://gitlab.com/psmisc/psmisc/-/archive/${SNAPSHOT}/psmisc-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/psmisc-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6"

DEPEND="
	virtual/curses
	app-build/libtool
"

src_prepare() {
	default

	eautoreconf
	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}

src_configure() {
	local myconf=(
		--disable-harden-flags
		--disable-nls
		$(use_enable ipv6)
	)
	econf "${myconf[@]}"
}

src_compile() {
	# This snapshot ships broken gettext recursion when NLS is disabled:
	# po/ lacks a usable Makefile, so avoid recursing there at make time.
	emake SUBDIRS='doc icons man-po testsuite'
}

src_install() {
	emake DESTDIR="${ED}" SUBDIRS='doc icons man-po testsuite' install
	rm -f "${ED%/}"/usr/bin/pstree.x11
}
