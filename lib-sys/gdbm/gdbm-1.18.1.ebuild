# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic multilib multilib-minimal

DESCRIPTION="Standard GNU database libraries"
HOMEPAGE="https://www.gnu.org/software/gdbm/"
SRC_URI="mirror://gnu/gdbm/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/6"
KEYWORDS="amd64 arm64"
IUSE="nls +readline static-libs"

DEPEND="readline? ( lib-sys/readline:0=[${MULTILIB_USEDEP}] )"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	export ac_cv_lib_dbm_main=no ac_cv_lib_ndbm_main=no

	local myeconfargs=(
		$(use_enable nls)
		$(use_enable static-libs static)
		$(use_with readline)
	)
	ECONF_SOURCE=${S} econf "${myeconfargs[@]}"
}
