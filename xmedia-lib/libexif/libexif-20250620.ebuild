# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
HOMEPAGE="https://github.com/libexif"
SNAPSHOT=1a31f67eabcca2be32e12adaf0b5892dee71a5b7
SRC_URI="https://github.com/libexif/libexif/archive/${SNAPSHOT}.tar.gz -> libexif-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libexif-${SNAPSHOT}"

KEYWORDS="amd64 arm64"
LICENSE="LGPL-2.1"
SLOT="0"

IUSE="doc nls static-libs"

RDEPEND="nls? ( app-build/gettext )"
DEPEND="${RDEPEND}
	app-dev/pkgconf
	doc? ( app-tex/doxygen )
	nls? ( app-build/gettext )"

ECONF_SOURCE=${S}

PATCHES=( "${FILESDIR}"/libexif-0.6.13-pkgconfig.patch )

src_prepare() {
	eautoreconf
	default
	sed -i -e '/FLAGS=/s:-g::' configure || die #390249
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable nls) \
		$(use_enable doc docs) \
		--with-doc-dir="${EPREFIX}"/usr/share/doc/${PF}
}
