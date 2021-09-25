# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="tool for generating C-based recognizers from regular expressions"
HOMEPAGE="http://re2c.org/"
SRC_URI="https://github.com/skvadrik/re2c/releases/download/${PV}/${P}.tar.xz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

src_configure() {
	local myconf=(
		ac_cv_path_BISON="no"
		$(use_enable debug)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
