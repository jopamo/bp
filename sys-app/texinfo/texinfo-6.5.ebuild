# Distributed under the terms of the GNU General Public License v2

# Note: if your package uses the texi2dvi utility, it must depend on the
# virtual/texi2dvi package to pull in all the right deps.  The tool is not
# usable out-of-the-box because it requires the large tex packages.

EAPI=6

inherit flag-o-matic

DESCRIPTION="The GNU info program and utilities"
HOMEPAGE="https://www.gnu.org/software/texinfo/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="nls static"

RDEPEND="
	dev-lang/perl
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	app-compression/xz-utils
	nls? ( >=sys-devel/gettext-0.19.6 )"

PATCHES=( ${FILESDIR}/perl5.28.patch
			${FILESDIR}/locale.patch )

src_configure() {
	use static && append-ldflags -static
	local myeconfargs=(
		--with-external-libintl-perl
		--with-external-Unicode-EastAsianWidth
		--with-external-Text-Unidecode
		$(use_enable nls)
	)
	econf "${myeconfargs[@]}"
}
