# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=096b5ff3c9079a38360ec76ba59b2b4c65fa04a8
	SRC_URI="https://gitlab.gnome.org/GNOME/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

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
		$(use_enable static-libs static)
		$(use_with crypt crypto)
		$(use_with debug mem-debug)
		$(use_with debug)
		--without-python
	)
		ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
