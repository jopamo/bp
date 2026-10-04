# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/less/"
SNAPSHOT=57c3b7706053e5f4ace7595a89e9a652943b8ac9
SRC_URI="https://github.com/gwsw/less/archive/${SNAPSHOT}.tar.gz -> less-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/less-${SNAPSHOT}"

LICENSE="|| ( GPL-3 BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	virtual/curses
	lib-core/libpcre2
"
DEPEND="${RDEPEND}"

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
