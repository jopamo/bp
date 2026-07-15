# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/less/"
SNAPSHOT=3b97f887be1ec7c7fbe9f7c99f4da9212798671b
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
	# Snapshot tarballs lack pre-generated author files expected by the
	# Makefile.in build and install targets.
	# Generate only what build/install require, and avoid less.man targets
	# that need nroff.
	emake -f Makefile.aut \
		help.c funcs.h lessmsg.inc \
		less.nro lesskey.nro lessecho.nro || die
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
