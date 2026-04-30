# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/less/"
SNAPSHOT=d3cffdef716aad98470ca0dcd20747c109ea3bef
SRC_URI="https://github.com/gwsw/less/archive/${SNAPSHOT}.tar.gz -> less-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/less-${SNAPSHOT}"

LICENSE="|| ( GPL-3 BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	virtual/curses
	lib-core/libpcre2
"

src_prepare() {
	# Snapshot tarballs lack pre-generated help.c/funcs.h and *.nro files
	# expected by Makefile.in install target.
	# Generate only what build/install require, and avoid less.man targets
	# that need nroff.
	emake -f Makefile.aut help.c funcs.h less.nro lesskey.nro lessecho.nro || die
	default
	eautoreconf
}
src_configure() {
	local myconf=(
		--with-regex=pcre2
		--with-editor="${EPREFIX}"/usr/bin/vim
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
