# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"

SNAPSHOT=5df99903aef143d605be69cbd4fbf246871cd113
SRC_URI="https://gitlab.gnome.org/GNOME/libxslt/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="amd64 arm64"

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
		$(use_with debug)
		--without-python
	)
		ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
