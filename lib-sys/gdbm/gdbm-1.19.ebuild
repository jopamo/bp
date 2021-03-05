# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Standard GNU database libraries"
HOMEPAGE="https://www.gnu.org/software/gdbm/"
SRC_URI="mirror://gnu/gdbm/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls +readline static-libs"

DEPEND="readline? ( lib-sys/readline:0= )"

src_prepare() {
	sed -r -i '/^char.*parseopt_program_(doc|args)/d' src/parseopt.c
	default
}

src_configure() {
	export ac_cv_lib_dbm_main=no ac_cv_lib_ndbm_main=no

	local myconf=(
		$(use_enable nls)
		$(use_enable static-libs static)
		$(use_with readline)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
