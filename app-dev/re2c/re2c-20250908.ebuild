# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="tool for generating C-based recognizers from regular expressions"
HOMEPAGE="http://re2c.org/"

SNAPSHOT=0bfddb867b0ab586a113b65da75d99a8af111727
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
