# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils libtool multilib-minimal git-r3 autotools

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
HOMEPAGE="https://github.com/libexif"
EGIT_REPO_URI="https://github.com/libexif/libexif.git"

KEYWORDS="amd64 arm64"
LICENSE="LGPL-2.1"
SLOT="0"

IUSE="doc nls static-libs"

RDEPEND="nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-text/doxygen )
	nls? ( sys-devel/gettext )"

ECONF_SOURCE=${S}

src_prepare() {
	eautoreconf
	epatch "${FILESDIR}"/${PN}-0.6.13-pkgconfig.patch
	sed -i -e '/FLAGS=/s:-g::' configure || die #390249
	elibtoolize # For *-bsd
}

multilib_src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable nls) \
		$(use_enable doc docs) \
		--with-doc-dir="${EPREFIX}"/usr/share/doc/${PF}
}
