# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="tool for generating C-based recognizers from regular expressions"
HOMEPAGE="http://re2c.org/"
SNAPSHOT=f1a46ca73a0855ea750d4f36c15747a99ae542f9
SRC_URI="https://github.com/skvadrik/re2c/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		ac_cv_path_BISON="no"
		$(use_enable debug)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
