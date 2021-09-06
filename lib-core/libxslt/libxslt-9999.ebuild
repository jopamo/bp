# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/${PN}.git"
	inherit git-r3
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=50f9c9cd3b7dfe9b3c8c795247752d1fdcadcac8
	SRC_URI="https://gitlab.gnome.org/GNOME/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="crypt debug static-libs"

DEPEND="
	lib-core/libxml2
	crypt?  ( lib-core/libgcrypt )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}
		--with-html-subdir=html
		$(use_with crypt crypto)
		$(use_with debug)
		$(use_with debug mem-debug)
		$(use_enable static-libs static)
		--without-python
	)
		ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
