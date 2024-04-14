# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"
SRC_URI="https://download.gnome.org/sources/libxslt/1.1/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="crypt debug static-libs"

DEPEND="
	lib-core/libxml2
	crypt?  ( lib-core/libgcrypt )
"

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
