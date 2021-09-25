# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for Neighbor Discovery Protocol"
HOMEPAGE="http://libndp.org"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/jpirko/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=e8b90ce2d6ebf846cb0c9a3255d4deacf075f9c4
	SRC_URI="https://github.com/jpirko/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--disable-static
		--enable-logging
	)
	ECONF_SOURCE=${S} econf ${myconf[@]}
}
