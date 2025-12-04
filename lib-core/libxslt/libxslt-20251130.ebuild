# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"
SNAPSHOT=35323d6a15f6e63c9919ddbc0abe64c90a0dd88a
SRC_URI="https://gitlab.gnome.org/GNOME/libxslt/-/archive/${SNAPSHOT}/libxslt-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxslt-${SNAPSHOT}"

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
		$(use_with debug)
		--without-python
	)
		ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
