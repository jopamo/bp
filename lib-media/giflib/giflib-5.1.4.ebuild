# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Library to handle, display and manipulate GIF images"
HOMEPAGE="https://sourceforge.net/projects/giflib/"
SRC_URI="mirror://sourceforge/giflib/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

src_configure() {
	local myeconfargs=(
		# No need for xmlto as they ship generated files.
		ac_cv_prog_have_xmlto=no

		$(use_enable static-libs static)
	)

	ECONF_SOURCE="${S}" \
	econf "${myeconfargs[@]}"
}
