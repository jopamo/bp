# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
HOMEPAGE="https://github.com/libexif"
SNAPSHOT=3e4003aaa75f4f1ab40c04641215e5e7db9bb47e
SRC_URI="https://github.com/libexif/libexif/archive/${SNAPSHOT}.tar.gz -> libexif-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libexif-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc nls static-libs"

QA_CONFIG_IMPL_DECL_SKIP=(
	localtime_s
)

RDEPEND="nls? ( app-build/gettext )"
DEPEND="${RDEPEND}
	app-dev/pkgconf
	doc? ( app-tex/doxygen )
	nls? ( app-build/gettext )"

ECONF_SOURCE=${S}

PATCHES=( "${FILESDIR}"/libexif-0.6.13-pkgconfig.patch )

src_prepare() {
	qa-policy-configure
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
	qa-policy-install
}
