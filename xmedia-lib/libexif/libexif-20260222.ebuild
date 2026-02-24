# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
HOMEPAGE="https://github.com/libexif"
SNAPSHOT=9a34c3f4f70d8e19d11d93f8551c79c5180f902f
SRC_URI="https://github.com/libexif/libexif/archive/${SNAPSHOT}.tar.gz -> libexif-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libexif-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc nls static-libs"

RDEPEND="nls? ( app-build/gettext )"
DEPEND="${RDEPEND}
	app-dev/pkgconf
	doc? ( app-tex/doxygen )
	nls? ( app-build/gettext )"

ECONF_SOURCE=${S}

PATCHES=( "${FILESDIR}"/libexif-0.6.13-pkgconfig.patch )

src_prepare() {
	use static-libs && lto-guarantee-fat

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

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
